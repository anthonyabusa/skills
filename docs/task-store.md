# Task store

Several skills read and write tasks (decompose, build-graph, vet-idea, decision-map, retro, close-out). They all use one store, chosen once by the `setup` skill and recorded in your `CLAUDE.md` or `AGENTS.md` as a line like `Task store: markdown` or `Task store: github`.

## Markdown (default)

One file, `TASKS.md`, at the repo root. Each task is a level-2 heading with an id, then fixed fields:

```markdown
## T-7 Export respects the redaction filter
- status: todo            # todo | doing | blocked | done
- why: exports must never leak redacted fields
- done when: a task with a redacted field exports without it in CSV and JSON (test)
- depends on: T-5, T-6
- kind: task              # task | decision | test (vet-idea's "test first")
- notes: blocked on nothing; wake 2026-11-01 for a test-first idea
```

Rules:
- Ids only grow (`T-<n>`, next is max + 1); never reuse one.
- A task is ready when its status is `todo` and every `depends on` task is `done`.
- Closing a task: set `status: done` and add one evidence line (`- evidence: tests/test_export.py passes, commit abc123`).
- Keep the file in git. It is the record of what was decided and why.

## GitHub issues (optional)

`Task store: github` uses the repo's issues through the `gh` CLI:
- a task is an issue; `why` and `done when` go in the body under those headings;
- status is a label (`todo`, `doing`, `blocked`); done is a closed issue with an evidence comment;
- `depends on` is a body line `Depends on: #12, #15`;
- kind is a label (`decision`, `test`).

Use it when other people already work from issues. Everything else in the skills is the same.
