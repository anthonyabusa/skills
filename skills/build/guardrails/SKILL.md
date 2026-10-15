---
name: guardrails
description: Keep an agent from destroying work. Careful mode checks what a destructive command would lose and takes the reversible path; freeze mode confines edits to one directory. Use when asked to be careful or to lock edits to a folder, or before any command that deletes, overwrites or rewrites history.
---

Prevents: an agent deleting, overwriting or force-pushing work that was not scratch.

Use when: the human asks for care or a scope lock, or you are about to run a command that deletes, overwrites, force-pushes or rewrites history.
Not for: ordinary edits to files you created this session, or read-only commands.

This skill is the habit. If your agent supports hooks, a hook that blocks the left column of the table below is the floor under it.

## Careful mode
Before any destructive command:
1. **Name what it destroys.** Run the read-only check first and show it: `git status --short`, `git log origin/<branch>..HEAD` (unpushed commits), `git stash list`, `ls` of the target, the row count of the table.
2. **If the check shows nothing to lose,** proceed and say so in one line (`clean: 0 unpushed, 0 untracked`).
3. **If it shows anything,** take the reversible path from the table below, or stop and ask. Never assume the loss is fine because the work "looks like" scratch.
4. **Chain only on success.** A destructive step runs only after the step before it is verified (exit 0 and the expected state, such as HEAD advanced after a commit). Never `a; destroy` or `a || true && destroy`.
5. **Never touch what you did not create** (another session's branch, worktree, stash or files) without the owner's go.

| Instead of | Use |
|---|---|
| `rm -rf <dir>` | move it to the trash or a dated backup dir; delete later |
| `git push --force` | `git push --force-with-lease` |
| `git reset --hard` | `git stash` or a backup branch first, then reset |
| `git branch -D <b>` | `git branch -d <b>` (refuses unmerged work); `-D` only after checking `git log main..<b>` is empty |
| `git clean -fdx` | `git clean -n` first (dry run), then delete only the listed paths |
| `git worktree remove --force` | `git -C <wt> status --short` first; force only when it is empty or committed |
| `git checkout -- <file>` / `git restore` | `git diff <file>` first; copy the file aside if the diff is not yours |
| overwrite an unread file | read it first; keep a `.bak` when it is not in git |
| `DROP` / `TRUNCATE` / `DELETE` without `WHERE` | a backup or export first, then a `SELECT` showing the rows that will go |
| `kubectl delete` / cloud resource delete | `--dry-run` or describe first; never in prod without the human |

## Freeze mode
1. `freeze <dir>`: record the allowed root in your working notes and say it back (`frozen to projects/x/`).
2. Before every write, check the target path starts with the frozen root. Outside it: do not write; name the file and why it needs changing, and ask.
3. Reads stay unrestricted. Generated files (lockfiles, build output) inside the root are fine.
4. `unfreeze` (or the human widening the root) ends it. Freeze also ends with the session; it does not carry over silently.

## Done when
- Every destructive command this session was preceded by its check, and the check's result was stated.
- No write landed outside a frozen root.
- Anything not yours was left as found, or touched only with the owner's go.

Draws on garrytan/gstack careful, guard and freeze, and mattpocock/skills git-guardrails-claude-code (both MIT). The text here is original.
