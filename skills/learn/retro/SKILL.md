---
name: retro
description: Look back over a window (a week, a sprint, a project) from evidence, commits, closed and stalled tasks, reverts, repeat fixes, corrections. Each pattern found becomes one concrete change minted as a task. Use at the end of a week or project, or when asked what went well or wrong.
---

Prevents: decisions based on memory or anecdote, missed systemic patterns, unmeasured improvements.

Use when: a window of work has closed (week, sprint, project) or the human asks what went well, what went wrong, or what to change.  
Not for: a single bug's root cause (use fix) or a session close (use close-out).

## Step 1: Pick the window
Default: the last 7 days. Name it in one line (`window: <from>..<to>`).

## Step 2: Gather evidence (counts and links, not impressions)
- Commits: `git log --since <from> --until <to> --no-merges --format='%h %s%n%b'`. Filter out bot and automated commits (`--invert-grep --grep=<their prefix>`) before counting.  
- Tasks: closed, reopened, stalled (`doing` with no update for 3 or more days) from the task store.  
- Reverts and repeat fixes: `git log --grep revert -i`, files fixed >1 in window.  
- Corrections: rules added to CLAUDE.md or AGENTS.md in the window, and "you missed" or "I thought we agreed" moments.  
- Previous retro: latest file in `docs/retros/`.

## Step 3: Find patterns
Require 2 or more instances; one-offs are notes. Sort into: repeated, slow, broke, worked. Name each with evidence (`3 PRs merged with red CI: 41, 44, 52`).

## Step 4: One change per pattern
For each harmful pattern, mint exactly one change: rule, skill edit, test, or tool, written to the task store with `why` citing the evidence. For each working pattern, state what keeps it. No blame. No lesson without change.

## Step 5: Close the last loop
For each change from last retro: did it ship? Did the pattern stop? Decide: keep, adjust, or drop. State verdict.

## Step 6: Save
Write `docs/retros/<date>.md` with these sections: `## Window`, `## Evidence`, `## Patterns`, `## Changes` (one line per change: the new task id in the task store and its evidence), `## Last retro` (one line per earlier change: `<change id>: keep | adjust | drop, <evidence>`). Create each change's task before writing the file. Commit. Keep money, credentials and other people's details out of it.

## Done when
- Every pattern cites evidence and has one change minted as a task, or a stated reason why none.  
- The previous retro's changes each have a verdict.  
- The retro file is committed.

Draws on garrytan/gstack retro, BMAD-METHOD retrospective and mattpocock/skills retro (all MIT). The text here is original.
