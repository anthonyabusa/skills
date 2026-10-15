---
name: red-first
description: Build testable code test-first: find the seam, write ONE failing test that states the behaviour, watch it fail for the right reason, then make it green (yourself or via a subagent) and review the diff. Prevents untested, overbuilt, or misaligned code.
---

Prevents: Untested, overbuilt, or misaligned code by enforcing a failing test before implementation.

Use when: Adding new logic with a testable seam (function, CLI, endpoint, parser, validator, state transition). Also when the behaviour can be clearly defined as input -> expected output.

Not for: Configs, prose, glue scripts without logic; UI visuals/layout; exploratory spikes; bugs in existing code (use fix instead).

1. Find the seam
   - Test the public interface only.
   - If the function's contract can't be stated in one sentence, revisit design.

2. Write ONE failing test
   - One test, one behaviour.
   - Name test after behaviour (`test_slugify_collapses_spaces`).
   - Use existing test runner and layout.
   - Assert real output, not mocks.

3. See it red, for the right reason
   - Run the test; it must fail on the assertion (or NotImplementedError/missing symbol).
   - Fix test if failure is due to typo, fixture error, or wrong path.
   - If test passes immediately, confirm if behaviour exists or test is vacuous.

4. Make it green
   - For small or judgment-heavy logic: write minimal implementation.
   - For bounded, mechanical work: commit red test, hand to subagent with "make this test pass, do not edit the test", then review the diff (step 5).

5. Review the green diff (never skip)
   - Confirm test file is unchanged.
   - No special-casing of test inputs, no swallowed exceptions, no skipped/xfail markers.
   - Implementation is minimal and consistent with codebase style.

6. Next behaviour
   - Repeat for edge cases, error paths.
   - Refactor only while green.
   - Stop when planned test points are covered.

## Done when
- Each behaviour has a passing test.
- Test file unchanged.
- Implementation is minimal and reviewed.

Adapted from mattpocock/skills tdd (MIT).
