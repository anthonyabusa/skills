---
name: pr-brief
description: Turn a branch into a PR whose body states what changed and why, the evidence it works, whether it is a one-way door, and its blast radius; run two review passes, answer review honestly, and merge only when the checks pass. Use when opening, updating or merging a PR.
---

Prevents: Merging unreviewed or misaligned changes, especially on sensitive or external surfaces.

Use when:
- Opening or updating a PR
- Needing to communicate changes clearly for review
- Handling schema migrations, external changes, or deletions (one-way doors)

Not for:
- Direct commits to main that bypass PRs under repo rules
- Trivial changes exempt from PR process

1. Write the PR body (in the repo's PR template if it has one):
   - **Summary**: What changed and why; link task by title and id (e.g., "Closes T-1234: Add user auth").
   - **Evidence**: Test output, probes, or screenshot paths showing verification.
   - **Door**: `one-way` if change affects public schema, data, money, or requires human approval; else `two-way`.
   - **Blast radius**: what this can break, and who or what depends on it.

2. Honor the Door:
   - A `one-way` PR waits for the human's explicit approval (a review approval or an agreed label) before merge.
   - Never self-approve or downgrade the Door; respect the gate.

3. Run both review axes:
   - **Standards**: the diff against the repo's conventions and the project's agent notes (CLAUDE.md or AGENTS.md).
   - **Spec**: the diff against the task's `done when`, item by item.
   - Run each pass in a fresh subagent or a second session, so the reviewer is not the author.
   - Fix findings or push back with evidence; never skip silently.
   - If a finding is out of scope, create a new task and link it.

4. Receive review honestly:
   - For every comment, check it against the code before acting; reviewers (human or model) are sometimes wrong, especially on a diff they did not fully see.
   - Respond with either a fix (cite commit) or one-line pushback with evidence.
   - Never agree just to close a thread, and never silently skip one.

5. Gate and merge:
   - Use `gh pr create --body-file <file>` or `gh pr edit` to update PR.
   - Run your repo's merge checks (CI green, branch current with main, no conflicts).
   - Merge only when all of them pass and the Door is cleared.

## Done when
- PR is open with complete body
- All review findings are resolved
- Merge checks pass and Door is cleared

Adapted from mattpocock/skills pr and code-review; receiving review draws on obra/superpowers receiving-code-review (all MIT).
