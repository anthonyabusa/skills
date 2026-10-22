---
name: ask
description: Which skill now? Reads the request and the repo's state and names the one skill to run next in the idea-to-ship pipeline, with a one-line reason. Use when unsure where to start, or at the start of any non-trivial request.
---

Prevents: skipping straight to code on work that needed vetting, shaping or a plan, and the opposite, running ceremony on a one-line fix.

Use when: a request arrives and it is not obvious which step comes first.
Not for: trivial work (a typo, a one-line config change). Just do it.

## The pipeline
| Stage | Skill | Enter here when |
|---|---|---|
| 0 Vet | `vet-idea` | the value of the idea is unproven |
| 1 Shape | `question-first` | the build is wanted but decisions are open |
| 1 Research | `research` | a fact decides the approach and nobody has checked it |
| 2 Map | `decision-map` | the effort is foggy: many open decisions that depend on each other |
| 3 Plan | `plan` | the work is bigger than one session |
| 4 Slice | `decompose` | an approved plan needs tasks |
| 5 Build | `build-graph` (many linked tasks), `red-first` (one testable change), `fix` (something is broken) | the work is defined |
| 5 Safety | `guardrails`, `human-step` | a destructive command is near, or a step only a human can do |
| 6 Ship | `pr-brief`, `honest-signoff`, `close-out` | the change is ready, or the session is ending |
| 7 Learn | `correction-loop` (after a correction), `retro` (after a week or a project), `write-skill` (a skill misfires) | something went wrong or a window closed |
| Talk | `plainly` (an explanation did not land), `questionnaire` (someone else holds the answers) | |
| UI craft | `motion` (an animation is added or reviewed), `break-ui` (UI built on tidy demo data), `mobile-native` (works on desktop, wrong on a phone), `prototype` (options before committing) | the work is UI polish |
| Swift | `write-swift` | the change touches Swift |

## Steps
1. Classify the request: bug, idea, task, question, or chat.
2. Check state: does a plan, task or decision map for this already exist? Is the task store set up (if not: `setup`)?
3. If the right skill depends on a fact only the human has (how big, how slow, what they already tried), ask for it in one short question first; never route on a guess.
4. Name ONE skill and the one-line reason (`vet-idea: the value of a client-email drafter is unproven`). If the request is trivial, say so and do it instead.
5. A skipped stage gets a reason in one clause (`skipping vet-idea: the human already decided to build this`).

## Done when
One skill is named with a reason, or the work is declared trivial and done.
