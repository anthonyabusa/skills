---
name: setup
description: One-time setup for these skills in a repo. Picks the task store (markdown TASKS.md by default, or GitHub issues), creates the files the skills write to, and records the choices in CLAUDE.md or AGENTS.md. Use when installing these skills in a new repo or when a skill says the task store is not set up.
---

Prevents: skills writing tasks, decisions and plans to different places, so nothing can find them later.

Use when: the skills are new to this repo, or a skill could not find the task store.
Not for: changing a single task (use the skill that owns it).

## Steps
1. Read `CLAUDE.md` / `AGENTS.md`. If a `Task store:` line exists, report it and stop.
2. Ask in one batch (AskUserQuestion in Claude Code), recommended option first:
   - Task store: markdown `TASKS.md` (recommended: works offline, lives in git) or GitHub issues (when the team already works from issues; needs the `gh` CLI signed in).
   - Notes file: `CLAUDE.md` (Claude Code) or `AGENTS.md` (Codex and others). Default to whichever exists.
3. Create what the choice needs, only if missing:
   - markdown: `TASKS.md` with a one-line header pointing to `docs/task-store.md`;
   - github: the labels `todo`, `doing`, `blocked`, `decision`, `test` (`gh label create <name>`);
   - both: the folders `docs/plans/`, `docs/decisions/`, `docs/maps/`, `docs/research/`, `docs/retros/` (each with a `.gitkeep`), and `GLOSSARY.md`.
4. Append to the notes file:
   ```
   ## Agent skills
   Task store: <markdown | github>  (format: docs/task-store.md)
   Plans: docs/plans/  Decisions: docs/decisions/  Maps: docs/maps/  Research: docs/research/  Retros: docs/retros/
   ```
5. Commit with an explicit list of the files you created.

## Done when
- The notes file has the `Task store:` line and the folder map.
- The chosen store exists (TASKS.md, or the labels).
- One commit holds exactly the setup files.
