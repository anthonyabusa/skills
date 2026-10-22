---
name: decision-map
description: "Map a foggy effort before planning it: write the destination, the decisions made so far, what is not yet known and what is out of scope, then mint each open decision as a kind:decision task. Use when effort spans multiple projects or has open unknowns."
---

Prevents: spinning on unclear direction or reopening settled decisions.

Use when:
- The effort spans more than one project
- There are open unknowns or unresolved decisions
- Planning is blocked by missing context

Not for:
- Well-scoped tasks with clear direction
- Efforts where all decisions are already made

## Step 1: Read what already exists
Review plans in `docs/plans/`, related projects, open tasks, settled decisions in the project's agent notes (CLAUDE.md or AGENTS.md). A decision already made is a "decision so far": never reopen here.

## Step 2: Write the map: `docs/maps/<slug>.md`
```markdown
# Map: <effort>
## Destination      what done looks like, one paragraph, measurable where possible
## Decisions so far each with date, who decided, and the source (plan, task, decision record)
## Not yet known    each open decision: id, question, mode (needs-human | research | spike), why it matters
## Out of scope     what this effort will not do, so it stays out
```
Source every claim; mark a guess `[assumption, confirm]`.

## Step 3: Mint each open decision
One task-store entry per decision: `kind: decision`, with the mode, the map slug, the options, the recommended option and its one-line why in `notes`.

- Mode `research`: a subagent investigates and returns a recommendation
- Mode `spike`: time-boxed throwaway prototype to answer a specific question; done when evidence (output, screenshot, timing) is recorded, not the code
- Mode `needs-human`: batch up to 4 questions into one sitting; use AskUserQuestion in Claude Code

## Step 4: Route
Route decisions by mode:
- `research`: assign to a subagent or cheaper model
- `spike`: build in scratch worktree, time-boxed, answer-only retained
- `needs-human`: batch into one AskUserQuestion with full context (in other agents, one message with each question, its options and your recommendation)

A choice someone owns (what the product does, who it is for, how people get or use it) is `needs-human` even when research informs it: research brings the recommendation, the human decides.

## Step 5: Close the loop
Write each answer into "Decisions so far", close its task with the answer as evidence, and hand the cleared map to plan.

## Done when
- All open decisions are resolved
- The map is updated with final decisions
- The cleared map is handed off to plan

Adapted from mattpocock/skills wayfinder; spike mode draws on mattpocock/skills prototype (both MIT).
