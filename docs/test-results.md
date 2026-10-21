# Test results

One held-out scenario per skill, three runs with the skill and three without it. "Outcome" counts runs that met every check on the result itself. "All checks" also counts the records the skill asks for (a saved file, a label, a commit shape), which the no-skill runs had no reason to produce. "Gain" is "yes" when outcomes improved, "form only" when outcomes matched but the skill added its records, and "none" when the skill changed neither.

| Skill | With: all checks | Without: all checks | With: outcome | Without: outcome | Gain |
|---|---|---|---|---|---|
| vet-idea | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| question-first | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| research | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| decision-map | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| plan | 3/3 | 0/3 | 3/3 | 1/3 | yes |
| decompose | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| build-graph | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| red-first | 3/3 | 3/3 | 3/3 | 3/3 | none |
| fix | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| guardrails | 3/3 | 1/3 | 3/3 | 1/3 | yes |
| human-step | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| pr-brief | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| honest-signoff | 2/3 | 0/3 | 2/3 | 3/3 | form only |
| close-out | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| correction-loop | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| retro | 3/3 | 1/3 | 3/3 | 3/3 | form only |
| write-skill | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| plainly | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| questionnaire | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| ask | 2/3 | 1/3 | 3/3 | 3/3 | form only |
| setup | 3/3 | 1/3 | 3/3 | 3/3 | form only |
| **Total** | 61/63 | 7/63 | 62/63 | 38/63 | |

After the first round, `question-first`, `build-graph`, `pr-brief` and `plainly` each got a one-line fix for a miss that repeated in at least two of three runs. Those four were then run again, both arms, and their rows above are from that second run. Before the fix they stood at 0, 0, 1 and 0 of 3 on all checks.

Two skills still missed after that, so each got a few variants of the failing step, three runs each, and the best one was then run on both arms. `plainly` kept ending on a note instead of the one next action; a fixed reply shape (answer first, one `Next:` line last) fixed it. `questionnaire` kept writing a flat numbered list; asking for a short heading per theme fixed it. Both now meet every check in 3 of 3 runs.

`build-graph` needed more than one line. Asking for the order table in a message failed in every run, across three wordings: the agent planned the order in its hidden reasoning and went straight to code. Writing the table to `docs/plans/build-order.md` and committing it before any code held in every run, and one more line stops it starting the next node before the last one's verify output is green. Its row is from that version.

`red-first` showed no gain, so its first scenario (`list --open`) was replaced with a harder one. The new prompt calls `count` a one-liner and says to just drop it in, and the suggested line would also print the whole list after the number. Without the skill, Sonnet still wrote the failing test first in all three runs and caught the problem. Its row is from the harder scenario: on this model, test-first is already the default, and the skill adds no measurable gain.

To see whether that holds for a weaker model, both `red-first` scenarios were also run with Claude Haiku as the agent (graders unchanged). Without the skill, Haiku wrote no test in any of 6 runs. With it, Haiku wrote a passing test in all 6.

| red-first on Haiku | With: all checks | Without: all checks | With: outcome | Without: outcome |
|---|---|---|---|---|
| first scenario (`list --open`) | 1/3 | 0/3 | 1/3 | 0/3 |
| harder scenario (`count`) | 2/3 | 0/3 | 2/3 | 0/3 |

Six test-harness defects were found and fixed during the runs, and the affected runs were rescored or rerun: a setup that pushed a commit the scenario says was never pushed (`correction-loop`), a pattern that missed the word "kept" (`retro`), a check that graded the skill's own hand-off as an outcome (`write-skill`), a check that called the recipient non-technical when the scenario says they know the NAS well (`questionnaire`, regraded), a script that failed any rule quoting the old "one short line" wording, even one replacing it (`correction-loop`, rescored), and a system Python upgrade mid-run that left the test runner without pytest (`question-first`, rerun).

## Haiku

The same held-out scenarios, run with Claude Haiku as the agent (three runs per arm, same graders, same skill text). Haiku follows the skills less fully than Sonnet. The first Haiku run met every outcome check in 34 of 63 runs with the skills. Eight skills where it scored 0 of 3 then got a structural fix: a line to write down (`Inside:` and `Outside:` in `vet-idea`), a file template with a required `Not tested:` line (`research`), a retro file template (`retro`), a fixed closing line (`pr-brief`), a rule that a check only the human can make keeps the task open (`honest-signoff`), a reply that must carry the answer (`plainly`), and a grep for the rule that caused the mistake, to be changed where it is (`correction-loop`). Each fix was run on Sonnet too, so its rows above are from the fixed text. Haiku now meets every outcome check in 48 of 63 runs with the skills, against 8 without. The first fixes for `correction-loop` (a plain rule) and `research` (a clause inside the `Checked:` line) gave no lift; both held only once the step became its own command or line.

| Skill | With: all checks | Without: all checks | With: outcome | Without: outcome | Gain |
|---|---|---|---|---|---|
| vet-idea | 2/3 | 0/3 | 3/3 | 0/3 | yes |
| question-first | 0/3 | 0/3 | 3/3 | 0/3 | yes |
| research | 2/3 | 0/3 | 2/3 | 0/3 | yes |
| decision-map | 1/3 | 0/3 | 1/3 | 0/3 | yes |
| plan | 0/3 | 0/3 | 2/3 | 0/3 | yes |
| decompose | 0/3 | 0/3 | 3/3 | 3/3 | none |
| build-graph | 1/3 | 0/3 | 3/3 | 1/3 | yes |
| red-first | 2/3 | 0/3 | 2/3 | 0/3 | yes |
| fix | 1/3 | 0/3 | 3/3 | 0/3 | yes |
| guardrails | 1/3 | 0/3 | 1/3 | 0/3 | yes |
| human-step | 0/3 | 0/3 | 3/3 | 1/3 | yes |
| pr-brief | 2/3 | 0/3 | 2/3 | 0/3 | yes |
| honest-signoff | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| close-out | 1/3 | 0/3 | 3/3 | 0/3 | yes |
| correction-loop | 1/3 | 0/3 | 2/3 | 0/3 | yes |
| retro | 1/3 | 0/3 | 1/3 | 0/3 | yes |
| write-skill | 0/3 | 0/3 | 3/3 | 0/3 | yes |
| plainly | 1/3 | 0/3 | 1/3 | 0/3 | yes |
| questionnaire | 0/3 | 0/3 | 1/3 | 0/3 | yes |
| ask | 0/3 | 0/3 | 3/3 | 3/3 | none |
| setup | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| **Total** | 22/63 | 0/63 | 48/63 | 8/63 | |
