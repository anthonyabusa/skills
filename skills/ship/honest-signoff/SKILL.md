---
name: honest-signoff
description: End every work stop honestly. Stop only for a real reason (input needed, all work done, or blocked), report in a fixed sign-off block where "Verified" means evidence you ran, and close with one decidable question. Use at the end of any turn or session that changed code, tasks or shared state.
---

Prevents: an agent stopping halfway with a takeable next step, calling unverified work done, or handing the human a checking chore dressed up as a status report.

Use when: a turn or session that committed code, changed tasks or touched shared state is about to hand control back.
Not for: pure conversation, quick answers, acknowledgements.

## Step 1: Is this stop legitimate?
A turn may end for exactly three reasons:
- **Input needed:** a decision, a credential, or something only the human can see or do.
- **All work done:** nothing in scope is left that you could take next.
- **Blocked:** a named blocker that you cannot clear.

Not a reason: "the work is committed", "a slice finished", or wanting permission to continue a direction already agreed. If you know the next in-scope step and need nothing from the human, do it instead of stopping. The tell of a bad stop: status `in-progress`, a takeable `Next`, and no real `Asks`.

## Step 2: Write the sign-off block
```
**<area> > <task id + title, or a short label>**: <done | blocked | in-progress>
- Done: <1-3 bullets of what changed>
- Verified: <evidence you ran: test output, a probe, a screenshot taken after the change>
- Check: <only if the human must look at something themselves; else omit>
- Proposed <X>: <the options, in full, when a decision is needed>
- Next: <one action, not a question>
- Asks: <what you need from the human; omit if nothing>
```
Rules:
- **Done means done.** A `done` block has no forward `Next`. If there is an in-scope next step, the work is not done: do it.
- **Verified is yours.** Only evidence you produced this session. "Should work", "looks right", or a test you did not run are not verification. Never move verification onto the human by writing it as a `Check`.
- **Name the rung honestly.** Merged is not deployed; deployed is not tested in the UI; tested in the UI is not live with real users. Say which one you reached.
- **Self-contained.** A proposal goes in the block in full, never "see above" or a file path alone.
- One line per field, no filler. Lead with the area and task so a reader with no scrollback knows what this is.

## Step 3: Close with one question
When anything needs the human (an `Asks`, a `Check`, a `Proposed`), end with a single decidable question (AskUserQuestion in Claude Code): the decision or direction that gates further work, 2-4 options, recommended first, each option carrying its full content. Never ask "shall I continue?" about agreed work, and never invent a question just to have one.

## Done when
- The stop has one of the three legitimate reasons, stated by its status.
- The block is present, and every `Verified` item is evidence you ran.
- A `done` block carries no `Next`.
- The turn ends on a real, decidable question, or on nothing when nothing is needed.
