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
   - Run each prompt in its own fresh headless session with the skill installed (`claude -p "<prompt>"`, `codex exec "<prompt>"` or your agent's equivalent) and record whether the skill loaded. A subagent asked "which skill would you pick?" is not a routing test.
   - Every should-fire prompt fires and every near-miss stays quiet; otherwise sharpen the description and rerun all of them.

6. Test the behaviour
   - Seed a real scenario the skill should handle in a scratch copy (a small repo, a failing test, a foggy request).
   - Run the skill there in a fresh headless session, not a subagent of this one.
   - Read the transcript against each step. Every slip (a skipped step, a guessed value, a wrong file) traces to a line in the skill: fix that line, then run the scenario again. Repeat until a run comes back clean.

7. Install and commit
   - Put the skill where the repo's agent loads skills (`.claude/skills/<name>/` for Claude Code, `.agents/skills/<name>/` for Codex and others; use the folder the repo already has).
   - Commit it with a message that records both tests: the prompts and their results, the scenario, each fix, and the clean final run.

## Done when
- Every should-fire prompt loaded the skill and every near-miss did not, each in its own fresh session.
- The last headless run on a real scenario followed every step with no slips, and it ran after the last edit.
- The skill is installed where the repo's agent loads skills, and the commit records both tests.

Draws on obra/superpowers writing-skills, BMAD-METHOD agent evals and mattpocock/skills writing guidance (all MIT). The text here is original.
