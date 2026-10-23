---
name: plan
description: Write a reviewable build plan at docs/plans/PLAN-<slug>.md after reading the repo, with a premortem for risky work and a four-lens review. Use before any feature, integration, migration or refactor bigger than one session, or when the build has more than one moving part.
---

Prevents: building on a guessed picture of the system (the plan says one framework, the repo uses another) and finding the failure you could already have seen after the code is written.

Use when: the work is bigger than one session, touches shared or user-facing code, moves data, or spans several files with an order that matters.
Not for: one-file mechanical edits, config one-liners, pure research with nothing to build.

## Step 1: Read the repo first
- Open the code and config the work touches. Find the real stack, entry points and the patterns already in use. Never guess them.
- List what exists that the plan can reuse or extend, and any file the request names that does not exist.
- This becomes the plan's **Current state** section. Every claim there points at a path.
- Current state only describes. Write what exists and how it works today; keep every proposal, critique and "should" out of it, for Approach. A current state mixed with opinions hides what is actually there. Where two sources disagree (a task marked done, code that lacks it), state both facts side by side with no verdict; the verdict and what follows from it go in Approach.

## Step 2: Check the approach
Name the one or two facts that decide the approach (an API's limits, a library's behaviour, how the repo already solves a neighbour problem). Check each (read the docs or the code, or use the `research` skill) and note the answer with its source. Unknown after checking: say so and plan a spike for it.

## Step 3: Write the plan
Create `docs/plans/PLAN-<slug>.md`:

```markdown
# Plan: <title>
Status: draft            # draft | approved | done
## Goal              one sentence a stranger could test
## Current state     what exists today, each point with a path
## Approach          the chosen shape, and the alternative rejected with its why
## Phases            ordered; each one:
### Phase 1: <name>
- [ ] <change>, in <files>
Automated checks: `<command>` (tests, type check, a probe) that exit 0 when the phase is done
Manual checks: <what a person must look at>, or none
## Risks             or the premortem (Step 4) for risky work
## Verification      the tests, probes or renders that prove done
## Out of scope      what this plan will not do
```

Keep it a decision record, not an essay. A section with nothing to say gets one line saying so.

Every phase needs at least one automated check a builder can run without asking. The checks are how a build resumes: it starts at the first phase whose checks do not pass, ticks the boxes as it goes, and does not start the next phase while a check is red.

## Step 4: Premortem (risky work only)
Run it when the work moves data, changes a schema, touches auth or money, is hard to roll back, or spans more than three phases.
1. Assume it is three months later and this shipped and failed. Write the three most likely reasons, each specific enough to test.
2. For each: the earliest signal it is happening, and the mitigation now in the plan (a test, a phase reorder, a flag, a backup).
3. A failure with no mitigation is either accepted in writing with its why, or the plan changes.

## Step 5: Four-lens review
One pass per lens, one line each, against the written plan:
- **Owner:** is this the right problem, and the smallest version that solves it?
- **Engineer:** does the approach fit what exists; what breaks under load, failure or concurrency?
- **User:** what do they see first, and where do they get stuck?
- **Operator:** how is it verified, rolled back, and noticed when it breaks at night?

A lens that finds nothing says so in one line. A finding edits the plan; it does not become a footnote.

## Step 6: Approve and link
- Share the plan file for review and ask one question: approve, adjust, or discard (AskUserQuestion in Claude Code, approve first).
- Approved: set `Status: approved`. The plan is now the contract for `decompose` and the build.
- Add the plan path to the task's `notes` in the task store.

## Done when
- `docs/plans/PLAN-<slug>.md` exists with every section, and Current state cites real paths and holds no proposals.
- Every phase has a runnable automated check.
- Risky work has a premortem with a signal and a mitigation per failure.
- All four lenses ran, and their findings are in the plan.
- The human approved it, and the task links to it.

The lens pass draws on garrytan/gstack plan reviews (MIT). The describe-only current state and per-phase checks draw on humanlayer's create_plan and implement_plan commands (Apache-2.0).
