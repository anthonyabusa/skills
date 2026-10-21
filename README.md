# skills

Agent skills for taking an idea all the way to shipped work without skipping the parts that usually get skipped: checking the idea is worth building, settling the decisions before the code, testing first, and reporting what actually happened instead of what was hoped.

I built these for my own daily work with Claude Code and Codex, used them on real projects, and stripped out everything tied to my setup. They need nothing but a git repo and an agent that reads `SKILL.md` files.

## The pipeline

| Stage | Skills | What it buys you |
|---|---|---|
| 0 Vet | `vet-idea` | You find out an idea is not worth building before you build it. |
| 1 Shape | `question-first`, `research` | Every question that would change the build gets asked once, in one batch, and the answers are saved where the next session will find them. |
| 2 Map | `decision-map` | A foggy effort becomes a short list of decisions, each routed to you, to research, or to a throwaway spike. |
| 3 Plan | `plan` | A written plan with a premortem, so the failure you can already see gets a mitigation before it happens. |
| 4 Slice | `decompose` | Thin vertical slices with explicit dependencies, checked for coverage against the plan. |
| 5 Build | `build-graph`, `red-first`, `fix`, `guardrails`, `human-step` | Test-first changes, root-cause fixes, a pause before anything destructive, and clean hand-offs for the steps only a person can do. |
| 6 Ship | `pr-brief`, `honest-signoff`, `close-out` | PRs that state their evidence and blast radius, and session endings that say what was verified rather than what was attempted. |
| 7 Learn | `correction-loop`, `retro`, `write-skill` | A correction fixes the rule that caused the mistake, not only the instance; a weekly look back; a way to build and test new skills. |
| Talk | `plainly`, `questionnaire` | Explanations re-pitched when they miss, and question sets for the person who actually holds the answers. |

Two plumbing skills sit underneath: `setup` picks where tasks live, and `ask` names the right skill for a request when it is not obvious. Not every request needs every stage; `ask` says which ones a request can skip, and why.

## Install

As a Claude Code plugin:

```
/plugin marketplace add anthonyabusa/skills
/plugin install skills@anthonyabusa
```

Or copy the folders you want from `skills/` into `.claude/skills/` (Claude Code) or `.agents/skills/` (Codex and others). Then run the `setup` skill once per repo. If you already have personal skills with the same names (in `~/.claude/skills`), Claude Code loads those first; rename or remove them so these load.

## Where tasks live

Several skills read and write tasks. By default that is one `TASKS.md` file at the repo root, in git, with a fixed shape: an id, a status, why it exists, what done means, and what it depends on. If your team already works from GitHub issues, `setup` can point the same skills at issues instead. The format is in [docs/task-store.md](docs/task-store.md).

## How the skills are written

Each skill opens with the failure it prevents, then when to use it and when not to, then numbered steps, then a `Done when` list you can check. The bar for every step is that a model following it cold, in a repo it has never seen, does the right thing. They were tested on one held-out scenario per skill, never used to tune the text. Claude Code (Sonnet) ran each scenario three times with the skill and three times without it, with a simulated person answering any questions it asked. Facts in the final repo were checked by script; judgment calls were graded three times by a model that never saw the skill, and the majority decided. Across 63 runs per arm, 62 met every outcome check with the skills and 38 without. Counting the records each skill asks for as well, it was 61 against 7. One skill showed no gain: `red-first` did as well without it, on a harder second scenario too, because Sonnet already writes the failing test first. With Haiku as the agent it did help: without it, Haiku wrote no test in any of 6 runs; with it, all 6 had a passing test. Nine skills got a short fix for a miss the held-out runs found (see the results page), so for those nine the scenario is no longer unseen; their rows come from a later run on the fixed text. With Claude Haiku as the agent, 44 of 63 runs met every outcome check with the skills and 8 without, after six skills got a structural fix for steps Haiku skipped. Per-skill results for both models are in [docs/test-results.md](docs/test-results.md).

## Credit

Several of these began as adaptations of skills from [mattpocock/skills](https://github.com/mattpocock/skills), [obra/superpowers](https://github.com/obra/superpowers), [garrytan/gstack](https://github.com/garrytan/gstack), [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD), [SuperClaude](https://github.com/SuperClaude-Org/SuperClaude_Framework) and [spec-kit](https://github.com/github/spec-kit). Ours have diverged, and each skill names its source in a credit line. Details are in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## License

MIT
