---
name: correction-loop
description: When the human corrects you, fix both the instance and the root-cause rule (test, skill, CLAUDE.md). Say what was updated and check for similar gaps. Prevents repeating the same class of mistake.
---

Prevents: repeating the same class of mistake after a human correction.

Use when:  
- The human points out a behavioral gap, error, or missing constraint.  
- A verify skill, retrospective, or audit surfaces a patterned failure.  
- You realize prior output violated a known rule or process.

Not for:  
- One-off typos or formatting slips with no procedural root.  
- Incidents already covered by an existing, working rule.  
- Ephemeral debugging notes not tied to behavioral change.

1. **Diagnose the root cause.**  
   - Ask: which artifact should have produced the right behaviour?  
   - A missing test, a missing rule in CLAUDE.md or AGENTS.md, a skill step that was absent or unclear, or a doc that said the wrong thing.  
   - Trace to the governing procedural source, not just the symptom.

2. **Fix the rule, not just the instance.**  
   - Edit the skill, CLAUDE.md, or process doc with a targeted delta (no rewrite).  
   - Preserve rationale: explain *why* the rule exists, not just what it does.  
   - Apply the fix to prevent recurrence across all future uses.

3. **Keep one source of truth.**  
   - If the lesson was also jotted in a notes or memory file, replace it with a pointer: `Corrected in: <path> (commit <sha>)`.  
   - The rule lives in the artifact that enforces it; notes only point at it.

4. **Check for similar gaps.**  
   - Audit recent work for the same class of mistake.  
   - Run a spot-check against the updated rule.  
   - Surface any findings with the same correction loop.

5. **Log the correction.**  
   - Include in the commit message body: what changed, why, and where.  
   - Tell the human in one line which artifact changed (`fixed: tests/test_export.py + AGENTS.md rule on redaction`).

## Done when:  
- The rule is fixed in the governing artifact.  
- The instance is corrected.  
- Any duplicate note points at the artifact.  
- The same class of mistake was checked elsewhere, and any hits were fixed.  
- The human was told which artifact changed.
