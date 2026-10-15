---
name: fix
description: Fix a bug by reproducing it, isolating the root cause, and applying a minimal, verified fix. Prevents regressions by adding checks and routing lessons. Use when something is broken, failing, or slow.
---

Prevents: fixing symptoms instead of root causes, reintroducing bugs due to lack of verification.

Use when:  
- A bug is reported with a clear symptom (error, crash, regression, flaky behavior).  
- The issue is reproducible and not a one-off typo.  
- The fix requires root-cause analysis, not just a band-aid.  

Not for:  
- Feature development (use plan then build).  
- Trivial typos (just fix them inline).  
- Flaky tooling artifacts not tied to real defects.  

1. Build a red-capable check  
   - Create a tight, fast, deterministic test or script that fails when the bug is present.  
   - Use the minimal reproduction (curl, CLI, test, harness) that asserts the exact symptom.  
   - Rule out flaky tooling or transport noise before assuming a real defect.  
   - Done when: a command exists that goes red on the bug and can be run unattended.  

2. Minimize the repro  
   - Trim inputs, config, callers, and data until only load-bearing elements remain.  
   - Confirm the trimmed version still triggers the bug.  
   - Use the minimal version as the regression test.  

3. Hypothesize and trace root causes  
   - Generate 3-5 falsifiable hypotheses (e.g., "If X is broken, changing Y will fix it").  
   - Trace the failure path through code, data, and layers, ask "why" past the first answer.  
   - Rank hypotheses by likelihood and testability.  

4. Instrument and test  
   - Use debuggers, targeted logs (tagged so they are easy to remove), or probes to test predictions.  
   - Avoid "log everything", focus on boundaries between hypotheses.  
   - For performance bugs, measure first (timing, profiler), then bisect.  

5. Diagnose out loud  
   - State the root cause: "The bug is X because Y; symptom Z is downstream."  
   - If the mechanism isn't clear, return to tracing.  

6. Fix the root cause (no band-aids)  
   - Apply the fix at the correct layer, never suppress symptoms.  
   - Ensure exit codes, errors, and statuses reflect real outcomes.  
   - Fix all layers identified in tracing, not just the symptom.  

7. Verify empirically  
   - Re-run the red-capable check, watch it pass.  
   - Confirm the original symptom is gone and no regressions exist.  
   - Verify real outputs (response bodies, file contents, app behavior), not just status.  
   - Clean up debug logs and harnesses.  

8. Route the lesson
   - Ask what let this bug in, and put the answer where it will fire next time: the regression test (always, from step 2), a lint or type rule, a line in the project's agent notes (CLAUDE.md or AGENTS.md), or an edit to the skill that should have caught it.
   - A design choice behind the fix gets a decision record in `docs/decisions/`.
   - Write the root cause and the lesson in the commit message body.
   - Skip only for trivial typos.

9. Make it catchable
   - If the bug could return silently in production, add a health check or alert for its symptom.
   - If it cannot be detected automatically, say why in the commit message.

## Done when  
- The bug is fixed at the root cause.  
- The fix is verified with a passing check.  
- The lesson is routed (a test, a rule, a note, or a skill edit).  
- A regression check exists, or the reason it cannot is written down.  

Front half adapted from mattpocock/skills diagnosing-bugs (MIT).
