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
   - Search the instruction files first: `grep -n -i <topic> AGENTS.md CLAUDE.md`. A line there that allowed the mistake is the root cause.

2. **Fix the rule, not just the instance.**  
   - Change the line that caused the mistake, in the file where it already is. Adding a new rule in another file leaves the old line in force; replace the old wording instead of adding to it.
   - Only if no line covers it, add one to the file agents already read (AGENTS.md if it exists).  
   - Preserve rationale: explain *why* the rule exists, not just what it does.  
   - Apply the fix to prevent recurrence across all future uses.

3. **Keep one source of truth.**  
   - If the lesson was also jotted in a notes or memory file, replace it with a pointer: `Corrected in: <path> (commit <sha>)`.  
   - The rule lives in the artifact that enforces it; notes only point at it.

4. **Check for similar gaps.**  
   - Correct the instance too: if the bad commit is not pushed, `git commit --amend` it with the right message; if it was pushed, leave it and say so.
   - Audit recent work for the same class of mistake.  
   - Run a spot-check against the updated rule.  
   - Surface any findings with the same correction loop.

5. **Log the correction.**  
   - Include in the commit message body: what changed, why, and where.  
   - Reply in two lines: `fixed: <file and rule changed>, <instance fixed or why not>` and `checked: <what you audited>, <what you found>`.

## Done when:  
- The rule is fixed in the governing artifact.  
- The instance is corrected.  
- Any duplicate note points at the artifact.  
- The same class of mistake was checked elsewhere, and any hits were fixed.  
- The human was told which artifact changed.
- `git diff` shows the old line replaced in the file it was in.
