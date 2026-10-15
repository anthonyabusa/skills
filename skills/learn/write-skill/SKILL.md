---
name: write-skill
description: Author or edit a skill so it fires on the right prompts and behaves correctly when triggered. Use when creating a new skill or fixing one that misfires, misses prompts, or performs incorrectly.
---

Prevents: Skills that don't trigger on expected prompts, trigger incorrectly, or behave improperly when invoked.

Use when:
- Creating a new skill
- Fixing a skill that misfires or misses prompts
- Improving skill behavior in response to valid triggers

Not for:
- Running an existing skill
- Editing non-skill documentation

1. Define the failure the skill prevents
   - State the specific failure it addresses (for example "PRs merge before CI finishes")
   - If no clear failure, the skill isn't needed

2. Check for existing skill coverage
   - Read the existing skills' descriptions
   - Prefer extending existing skill over creating redundant one

3. Write the frontmatter
   - `name`: the folder name, lowercase with hyphens.
   - `description`: what it does AND when to use it, in the concrete words a real request would contain ("before any command that deletes", "when a PR is ready"). The agent decides whether to load the skill from this line alone, so vague wording means it never fires.
   - Keep it under about 400 characters.

4. Write the body
   - Open with `Prevents:` (the failure), then `Use when:` and `Not for:` (name the neighbouring skill to use instead).
   - Numbered steps with short imperative bullets; exact commands only where they are standard tools.
   - End with `## Done when`: observable checks, not "it works".
   - Credit any adapted source by name and license, and keep the text your own.

5. Test the routing
   - Write 3 or more prompts that should load the skill and 2 or more near-misses that should not (they belong to a neighbouring skill).
   - Run each in a fresh session and record whether the skill loaded. Every should-fire prompt fires and every near-miss stays quiet; otherwise sharpen the description and rerun.

6. Test the behaviour
   - Seed a real scenario the skill should handle (a small repo, a failing test, a foggy request).
   - Run the skill headless (for example `claude -p "<scenario>"`) with the tools it needs and nothing destructive.
   - Read the transcript against each step. Every slip (a skipped step, a guessed value, a wrong file) traces to a line in the skill: fix that line and rerun until clean.
   - Put the scenario and the result in the commit message.

## Done when` section listing observable completion criteria
   - Credit adapted sources by name and license (e.g., "Adapted from mattpocock/skills tdd (MIT)")

5. Run routing test
   - Add 3+ prompts that should trigger the skill and 2+ near-misses that should not
   - Test routing precision and recall (must be >=0.85)
   - Confirm no regression on existing tests

6. Run headless behavior DIAG
   - Seed real scenario exercising the skill
   - Run headless (e.g., `claude -p`) with limited tools, no writes
   - Verify all steps execute correctly; fix any slips in the skill text
   - Document DIAG results in commit

7. Register the skill
   - Add to `INDEX.md`
   - Sync to Codex surface
   - Commit with adapters

## Done when
- Every should-fire prompt loads the skill and every near-miss does not.
- A headless run on a real scenario follows every step with no slips.
- The commit records both tests.

Draws on obra/superpowers writing-skills, BMAD-METHOD agent evals and mattpocock/skills writing guidance (all MIT). The text here is original.
