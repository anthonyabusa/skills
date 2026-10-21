---
name: vet-idea
description: Decide whether an idea is worth building by restating it, checking existing solutions, running five forcing questions and three lenses, then returning a verdict (build, test first, park, drop) with evidence. Prevents investing in unproven ideas.
---

Prevents: building something that doesn't solve a real problem, misses opportunity cost, or ignores existing alternatives.

Use when: someone proposes a new product, feature, project, tool, or service whose value is unproven (e.g., "I have an idea", "what if we built").

Not for: work with established value (a task exists, a decision record covers it), bugs (use fix), or clear implementation tasks (use build).

1. Restate the idea in one sentence: `<who> has <problem>; <idea> gives them <outcome>`. If any slot is missing, identify which and ask for it.

2. Check what already exists:
   - Inside: search the task store, docs/decisions/, project notes, and code. Has this been built, tried, or rejected? A prior Drop ends the vetting unless something material changed.
   - Outside: short search for existing tools, libraries, or services that solve this. Cite sources. "Nothing exists" requires evidence. No web access: say the outside check was not run, and never claim nothing exists.
   - Write both results down as two lines before going on: `Inside: <where you looked, what you found>` and `Outside: <sources>` (or `Outside: not run, no web access`).

3. Run five forcing questions:
   - Pain: Who has this problem, how often, and what do they do today? Cite real evidence (complaints, workarounds, costs).
   - Why now: What changed that makes this urgent now?
   - Alternatives: What wins if we do nothing, use an existing tool, or do it manually? The idea must beat the best alternative.
   - Smallest test: What's the cheapest experiment (mock, manual run, spike) to validate it? State time cost.
   - Kill criteria: What result would make us stop? Define before the test.

4. Apply three lenses (one line each):
   - Skeptical user: Why might the target user not adopt it?
   - Owner in six months: Who maintains it? What's the runtime cost? What breaks first?
   - Opportunity cost: What else won't get done? Compare to current top priorities.

   Then, run the press-release test: Write a two-sentence announcement. If it lacks a compelling claim, note it.

5. Reach a verdict:
   - Build: Pain is real, no existing alternative wins, cost fits. Next: `question-first` if decisions are still open, else `plan` (or straight to the build for a one-session change).
   - Test first: Promising but unproven. Next: create a task for the smallest test with kill criteria and wake date.
   - Park: Worth it, not now. Next: create a waiting task with revival trigger.
   - Drop: Fails pain, alternatives, or opportunity cost. Next: record why in a decision record.

   Present the verdict, the restatement and the decisive evidence as one question (AskUserQuestion in Claude Code), recommended verdict first. If no human, take the recommended verdict, mark `assumed (recommended default)`, and save.

6. Save the outcome:
   - Build, test first, or park: Create a task in the task store (see docs/task-store.md) with a title, `why` (the restatement and evidence) and `done when`. Test first: `kind: test`, the kill criteria in `done when`, and a wake date in `notes`. Park: `status: blocked` with the revival trigger in `notes`.
   - Drop: Create a decision record in docs/decisions/ (`docs/decisions/NNNN-drop-<slug>.md`) with rationale and revival condition.
   - Save it in this turn, before your final reply, and name the saved path in that reply.

## Done when
- Restatement is complete (all three slots filled or gaps identified).
- Step 2 includes evidence of internal and external search.
- Each forcing question has evidence or was asked.
- One verdict is chosen, saved, and triggers the next step without pause.
- The `Inside:` and `Outside:` lines are in the reply or the saved record.

Draws on garrytan/gstack office-hours, BMAD-METHOD forge-idea and prfaq, and obra/superpowers brainstorming (all MIT). The text here is original.
