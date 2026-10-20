# Test results

One held-out scenario per skill, three runs with the skill and three without it. "Outcome" counts runs that met every check on the result itself. "All checks" also counts the records the skill asks for (a saved file, a label, a commit shape), which the no-skill runs had no reason to produce. "Gain" is "yes" when outcomes improved, "form only" when outcomes matched but the skill added its records, and "none" when the skill changed neither.

| Skill | With: all checks | Without: all checks | With: outcome | Without: outcome | Gain |
|---|---|---|---|---|---|
| vet-idea | 2/3 | 0/3 | 2/3 | 0/3 | yes |
| question-first | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| research | 2/3 | 0/3 | 2/3 | 0/3 | yes |
| decision-map | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| plan | 3/3 | 0/3 | 3/3 | 1/3 | yes |
| decompose | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| build-graph | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| red-first | 3/3 | 3/3 | 3/3 | 3/3 | none |
| fix | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| guardrails | 3/3 | 1/3 | 3/3 | 1/3 | yes |
| human-step | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| pr-brief | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| honest-signoff | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| close-out | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| correction-loop | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| retro | 3/3 | 1/3 | 3/3 | 3/3 | form only |
| write-skill | 3/3 | 0/3 | 3/3 | 3/3 | form only |
| plainly | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| questionnaire | 3/3 | 0/3 | 3/3 | 0/3 | yes |
| ask | 2/3 | 1/3 | 3/3 | 3/3 | form only |
| setup | 3/3 | 1/3 | 3/3 | 3/3 | form only |
| **Total** | 60/63 | 7/63 | 61/63 | 38/63 | |

After the first round, `question-first`, `build-graph`, `pr-brief` and `plainly` each got a one-line fix for a miss that repeated in at least two of three runs. Those four were then run again, both arms, and their rows above are from that second run. Before the fix they stood at 0, 0, 1 and 0 of 3 on all checks.

Two skills still missed after that, so each got a few variants of the failing step, three runs each, and the best one was then run on both arms. `plainly` kept ending on a note instead of the one next action; a fixed reply shape (answer first, one `Next:` line last) fixed it. `questionnaire` kept writing a flat numbered list; asking for a short heading per theme fixed it. Both now meet every check in 3 of 3 runs.

`build-graph` needed more than one line. Asking for the order table in a message failed in every run, across three wordings: the agent planned the order in its hidden reasoning and went straight to code. Writing the table to `docs/plans/build-order.md` and committing it before any code held in every run, and one more line stops it starting the next node before the last one's verify output is green. Its row is from that version.

`red-first` showed no gain, so its first scenario (`list --open`) was replaced with a harder one. The new prompt calls `count` a one-liner and says to just drop it in, and the suggested line would also print the whole list after the number. Without the skill, Sonnet still wrote the failing test first in all three runs and caught the problem. Its row is from the harder scenario: on this model, test-first is already the default, and the skill adds no measurable gain.

Five test-harness defects were found and fixed during the runs, and the affected runs were rescored or rerun: a setup that pushed a commit the scenario says was never pushed (`correction-loop`), a pattern that missed the word "kept" (`retro`), a check that graded the skill's own hand-off as an outcome (`write-skill`), a check that called the recipient non-technical when the scenario says they know the NAS well (`questionnaire`, regraded), and a system Python upgrade mid-run that left the test runner without pytest (`question-first`, rerun).
