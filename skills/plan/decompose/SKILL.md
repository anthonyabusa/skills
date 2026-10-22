---
name: decompose
description: "Turn an approved plan into tasks: thin end-to-end vertical slices, each sized to one session, written to the task store in dependency order with explicit depends-on links and a coverage check. Use after a plan is approved and the work spans more than one session."
---

Prevents: unbounded work, context-switching debt, layer-by-layer drift, and merge conflicts from long-lived branches.

Use when:
- The approved plan (PLAN-*.md) requires more than one session to complete.
- Work must be split into mergeable, verifiable units with clear acceptance criteria.
- Dependencies between units need to be explicit and enforceable.

Not for:
- Single-session tasks.
- Tasks without clear vertical slicing or acceptance criteria.

1. Cut vertical slices
- Each slice touches every layer it needs (schema, code, UI, docs) and delivers a behaviour you can run.
- Size each slice to fit one context window: if too big, split by behaviour, not by layer.
- Put the plan's acceptance points for this slice in its `done when`, including at least one check against the running system (not only unit tests), written as a command and its expected output, never "manual check".
- Note what the slice will not do, so it does not drift.

2. Order and wire dependencies
- For each slice, identify what must be merged first: those go in `depends on`.
- Prefer few edges: only block if a slice cannot be built or verified without the other.
- Parallel-ready slices have no dependency edge.
- Write tasks in dependency order so every `depends on` id already exists.

3. Write the tasks to the task store
- Take the next free ids (`T-<max+1>` onward in TASKS.md).
- Each task, in the format of docs/task-store.md:
  - title: `<plan> slice k: <behaviour>`
  - why: the plan goal this slice advances, plus the plan path
  - done when: the acceptance points from step 1
  - depends on: the ids from step 2
- If the idea already has a task (from vet-idea), keep it as the parent: list the slice ids in its `notes` and close it when the last slice is done. It is not a `depends on` edge.
- Check before saving: no cycles, no task depending on itself, no unknown ids.

4. Coverage check
- Cross-check plan goals, phases, and acceptance points against each task's `done when`.
- Ensure no slice implements unplanned work.
- Verify terminology matches plan and glossary.
- Confirm each `depends on` link corresponds to a real dependency.
- Report coverage as a mapping a reader can check, each plan point with the task ids that cover it (`acceptance 2 -> T-4, T-6`), then the total: `coverage: 7/7 plan points, 0 orphan slices`.

5. Show the graph
- Output a table: id, title, depends on, ready now (yes or no).
- Start the first ready slice; the plan approval already covers it.

## Done when
- Every slice is in the task store with its `done when` and `depends on`.
- Coverage check passes with no gaps.
- The table is shown and the first ready slice is in progress.

Adapted from mattpocock/skills to-tickets (MIT); the coverage check draws on github/spec-kit analyze (MIT).
