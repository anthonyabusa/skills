---
name: build-graph
description: Build a set of dependent tasks in prerequisite order, halting downstream nodes when a failure occurs, while allowing independent branches to continue. Use for decomposed projects or linked tasks with defined dependencies.
---

Prevents: Building tasks out of order or missing dependency constraints in multi-task workflows.

Use when: several tasks are linked by `depends on` (usually the output of decompose).

Not for: a single task with no dependencies; use red-first or fix instead.

1. Write the graph down
   - From the task store, collect the target tasks and their `depends on` links. Drop links to tasks already `done`.
   - A link to an unfinished task outside this run blocks the graph: finish that task first, or add it to the run.
   - Before building any node, write the order as a short table in your reply: node, depends on, verify command. A node without a verify command is not buildable; give it one first.

2. Fan out the independent nodes
   - Nodes with no dependency path between them can run at the same time, each in a subagent working in its own git worktree, so checkouts do not collide.
   - Do not fan out nodes that touch the same files; run those in sequence, or add an edge.
   - Merge the results one at a time, bringing the branch current with main after each merge.

3. Walk the graph
   - Build a node only when every node it depends on is green. Without fan-out, build one node at a time: finish, verify and record it before writing code for the next.
   - Per node: set it to `doing` in the task store, build it (red-first where there is a testable seam), run its verify command, record the result.
   - Long graphs: run nodes in the background and keep a per-node log.

4. Handle results
   - **Green nodes**: Merge only after passing your repo's merge checks (CI green, branch current with main, no conflicts). Close task with run log as evidence.
   - **Red node**: Halt all downstream nodes. Fix the failing node first (using `fix`), then resume from it.
   - **Halted nodes**: Not failures, intentionally paused. Report by title; never mark as done until parent recovers.

5. Sign-off evidence
   - List each node with its status (green, red, halted) and the verify output that proves it.

## Done when
- All buildable nodes are completed in dependency order.
- Red nodes are isolated and reported for fixing.
- Halted downstream nodes are documented, not falsely marked done.
- Final state is verified and merge-safe.

Adapted from mattpocock/skills implement-spec; fan-out draws on obra/superpowers dispatching-parallel-agents and using-git-worktrees (all MIT).
