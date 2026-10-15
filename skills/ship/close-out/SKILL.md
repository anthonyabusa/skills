---
name: close-out
description: Bank work so nothing is lost between sessions. Checkpoint mid-session (verify, commit with intent, keep going) or close out at session end (commit, push, update the task store, write a handoff note the next session can start from). Use after finishing a discrete piece of work, or when the session is ending.
---

Prevents: work lost to a crash or a closed terminal, a task store that no longer matches reality, and a next session that has to rediscover where things stood.

Use when: a discrete piece of work just finished (checkpoint), or the human says to wrap up, end or close out (close-out).
Not for: trivial one-line edits; unverified work (finish or revert it first).

## Checkpoint (mid-session, keep working)
1. **Verify.** Run the checks for what you just finished (its tests, its probe). Red means it is not ready to bank: fix it first.
2. **Scan for secrets.** Look at the diff for keys, tokens, `.env` contents or private keys before committing. Found one: remove it and recommend rotation.
3. **Commit with explicit paths and intent.** `git commit -- <paths>` (add new files with `git add <file>` first). Never `git add -A`: it sweeps in work that is not yours. The message says what changed and why, and names the evidence.
4. Keep working on the next step.

## Close-out (session end)
1. Run the checkpoint steps for anything not yet banked.
2. **Push.** If the push is rejected, do not force it and do not rebase someone else's work away: bring the branch current (`git pull --rebase` on your own branch only), re-run the checks, push again, or leave the commit local and say so.
3. **Update the task store.** Done tasks get `status: done` and an evidence line; tasks still in flight say exactly where they stopped in `notes`; new work you discovered becomes new tasks, not a line in chat.
4. **Write the handoff note** in `docs/handoff.md` (replace the previous one) or the project's agent notes:
   ```markdown
   ## Handoff <date>
   Done: <what landed, with commits or PRs>
   In flight: <what is half-done, and where it stopped>
   Next: <the single next action, and the skill to start it with>
   Open questions: <what needs the human>
   ```
5. **Leave it clean.** Nothing uncommitted that matters, no stray branches or worktrees you created, no background jobs still running.

## Done when
- Every finished piece of work is committed with a message that carries its why and evidence.
- At close-out: pushed (or the reason it is not), the task store matches reality, and the handoff note names one next action.

The handoff note draws on mattpocock/skills handoff (MIT).
