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
| build-graph | 0/3 | 0/3 | 3/3 | 3/3 | none |
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
| plainly | 1/3 | 0/3 | 1/3 | 0/3 | yes |
| questionnaire | 0/3 | 0/3 | 2/3 | 0/3 | yes |
| ask | 2/3 | 1/3 | 3/3 | 3/3 | form only |
| setup | 3/3 | 1/3 | 3/3 | 3/3 | form only |
| **Total** | 52/63 | 7/63 | 58/63 | 38/63 | |

After the first round, `question-first`, `build-graph`, `pr-brief` and `plainly` each got a one-line fix for a miss that repeated in at least two of three runs. Those four were then run again, both arms, and their rows above are from that second run. Before the fix they stood at 0, 0, 1 and 0 of 3 on all checks.

`build-graph` still misses one step in every run: it builds in the right order but does not first show the order as a table. Two further rewordings did not change that, so they were left out.

Four test-harness defects were found and fixed during the runs, and the affected runs were rescored or rerun: a setup that pushed a commit the scenario says was never pushed (`correction-loop`), a pattern that missed the word "kept" (`retro`), a check that graded the skill's own hand-off as an outcome (`write-skill`), and a system Python upgrade mid-run that left the test runner without pytest (`question-first`, rerun).
