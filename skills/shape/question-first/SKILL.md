---
name: question-first
description: Settle the decisions behind a build or a design before acting, and save each answer where the next session will find it. Use when a non-trivial build has open choices, or on "how should we", "design", "which approach" and strategy questions. Build mode asks once then runs to done; design mode walks the decision tree in rounds.
---

Prevents: acting on foggy or unshaped work that leads to rework, misalignment, or decision debt.

Use when:
- Work is non-trivial and unshaped (a build with open choices)
- Prompt involves "how should we", "design", "think through", "brainstorm", "which approach", or strategy
- A decision lacks a settled answer

Not for:
- Trivial edits
- Bugs with clear symptoms (use fix)
- Pure lookups
- Directions already settled in the session

## Step 0: Pick the mode (state it in one clause)

| Signal in the prompt or task | Mode |
|---|---|
| A concrete deliverable ("build", "add", "wire up", "implement") with a few open choices | **Build** |
| "How should we", "design", "think through", "brainstorm", "which approach", strategy, architecture, a decision with no answer yet | **Design** |
| Both (a build whose shape is still foggy) | **Design** first, then **Build** for the agreed slice |

When unsure, pick Build if you could write the plan today with only defaults missing; pick Design if the plan itself depends on answers you do not have.

## Step 1: Inspect before asking

Read the code, config, docs, prior decision records (`docs/decisions/`), project's agent notes (CLAUDE.md or AGENTS.md), and the task store. Never ask a question the repo already answers. Every question must be one a wrong guess would make expensive.

## Build mode: one batch, then run

1. Write a brief plan (3-7 lines) and list every blocking question.
2. Ask them all in ONE batch, AskUserQuestion in Claude Code (up to 4 questions, 2-4 options each, recommended option first and labelled "(Recommended)").
3. Save each answer (Step 3), then run to done with no further confirmation pauses. Mid-build forks that are reversible: make the call and note it.

## Design mode: frontier rounds

1. Map the decision tree: the destination, the decisions that gate it, and which decisions depend on which.
2. Each round, ask only the **frontier**: the 1-4 decisions whose answers unblock the most of the tree right now. Each question carries a recommendation and the one-line why.
3. After each round, save the answers (Step 3), prune branches the answers closed, and compute the next frontier.
4. Stop when every decision that blocks the build is settled. Then hand off: `plan` for anything bigger than one session, or Build mode for a single slice.
5. Headless or no human in the loop (a subagent, a headless run): take the recommended option for each question, record it as `assumed (recommended default)`, and still save it.

## Exit gate: ready to build?

Before handing off, score the five checks below. Build only on five yeses; any no names the gap and loops back (one more frontier round, a spike, or a read). Write the result in one line (`ready: 5/5` or `not ready: no kill criteria`).

1. The goal is one sentence a stranger could test.
2. Every decision that changes the build is settled or explicitly assumed.
3. The repo was read: no question asked that the code already answers, no plan for a thing that exists.
4. The done-when is observable (a test, a probe, a render), not "works".
5. The riskiest unknown has a named first move (spike, test, or read).

## Step 3: Save each answer as it lands (not at the end)

A settled answer lives in chat only until the next compaction. Write it immediately, in the store that matches its kind:

| Answer kind | Store | How |
|---|---|---|
| A term (what we call a thing) | `GLOSSARY.md` | Add `### <Term>` with a one-line definition and an `Avoid:` line listing rejected or retired names. Update the existing entry if the term is already there. |
| A decision (A over B, with a why) | Decision record | Create `docs/decisions/NNNN-slug.md` with context, decision, alternatives, consequences. |
| A preference or standing rule from you | Project's agent notes | Add to `CLAUDE.md` or `AGENTS.md`. |
| A fact about one task (scope, done-when, blocker) | The task store | Update task fields (e.g., status, done-when, depends on). |

Name each write in the visible reply in one line (`saved: glossary "Lane"; DR-0007`). Redact as always: no money, credentials, or third-party identifiers in any store.

## Done when

- The mode was named, and every blocking question was asked in one batch (Build) or in frontier rounds until the tree was settled (Design).
- Every settled answer is in its store before the turn ends, and the reply names each write.
- The work moved on to `plan`, `build-graph` or execution without a "shall I proceed?" pause.

Adapted from mattpocock/skills grill-me and grill-with-docs (MIT); the exit gate draws on SuperClaude's confidence check (MIT).
