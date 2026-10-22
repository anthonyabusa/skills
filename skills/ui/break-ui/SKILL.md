---
name: break-ui
description: "Stress-test a component or screen with realistic worst-case data (long names, unbroken emails and slugs, counts of 0, 1 and 1,284, missing fields, translated labels) at 390px, then show each break next to its fix. Use when a card, list, row or screen was built against tidy demo data, or when asked to find edge cases or try the worst case."
---

Prevents: cards and rows that look right with "Jane Doe, 12 members" and break on real data: text running off the edge, actions pushed out of reach, a second chip cut to "Pr", "1 members", a floating button covering a control.
Use when: building or reviewing any data-driven UI.
Not for: invented nonsense data ("aaaa" x 5000). Every value must be something a real user or the schema could produce.

## Step 1: List every value the UI renders
- For each: source field, type, limit (from the Zod/Pydantic schema, DB column or `maxLength`), optional or not. No limit found is itself a finding: "unbounded".
- Include the easy-to-forget ones: counts in headers, badge and status text, relative times, the list length itself, data-driven button labels.

## Step 2: Build the worst case through the real data path
- Pick values from CATALOG.md. Spread different failures across the first rows instead of stacking them in row 1.
- Also cover: empty (0 items), one (every count at exactly 1), and huge (the realistic list ceiling).
- Save the worst-case dataset as a file in the repo (a fixture beside the tests), so it outlives this run.
- Inject the data at the same boundary the real data uses (fixture, API stub, or, on a live page, replacing the rendered text in the browser). Never hand-edit the component's CSS to make it break.

## Step 3: Render and look
- Playwright at 390px with `isMobile`, `hasTouch` and `reducedMotion: 'reduce'`, then the widest layout. Light and dark.
- Check: overflow (`document.scrollingElement.scrollWidth > innerWidth`, and any child whose right edge passes the viewport), clipped or cut-off items, controls covered by fixed elements (floating buttons, bottom bars), wrong plurals, raw numbers.
- Check the normal data too: a fixed button covering a control is often broken already.

## Step 4: Fix each break and show it
| What you see | Usual fix |
|---|---|
| Text runs past its box | `min-width: 0` on the flex/grid text column (`minmax(0,1fr)`) |
| Email, URL or slug runs off the edge | `overflow-wrap: anywhere`, or `line-clamp` for previews |
| Trailing action pushed off or clipped | `min-width: 0` on the middle, `shrink-0` on the action |
| Icon or avatar squished | `shrink-0` |
| Fixed button covers a control | move the control away from that corner, and pad the scroll end by the button's height |
| 0 items renders a bare header or blank space | an empty state in the shipped UI: one line saying what is missing and, if there is one, the next action |
| "1 members" | `Intl.PluralRules` |
| `1284`, `NaN` | `Intl.NumberFormat`, null guard |
| Truncated with no way to read it | `title` attribute or a detail view |

- A row of chips, tabs or filters that overflows: if the content is nice-to-have, keep one scrolling line and fade the trailing edge so it reads as scrollable; if it is essential, wrap so every item shows. A bare cut-off with no hint is always a break.
- Never truncate numbers, amounts or dates people compare.
- Apply the candidate fix the same way (CSS or code), re-render, and capture the after shot. Re-check the normal data so a fix does not regress it.

## Step 5: Report
Use this shape, every row filled:

| Break | Severity | Value that caused it (quoted exactly) | Fix (`file:line`) |
|---|---|---|---|

- Severity: Broken (unreadable or unreachable), Ugly (readable but wrong), Fragile (one step from breaking). The value column quotes the actual string or number, never "a long email" or "zero members": write `0 members` or the full address.
- Before and after shots cropped large, beside the table.
- **Held up:** a line naming the cases you tried that rendered fine, each with its value. Never omit it; if nothing held up, say so.
- Breaks with more than one right answer go to the person who owns the design as a decision, with each option rendered.
- Fixes to shipped code land through a task; the worst-case fixture stays as the regression test.

## Done when
- Every rendered value was tried with a catalog value, plus the empty, one and huge cases.
- Each break has a before shot, an after shot with the fix applied, and the fix location.
- The fixes are in the shipped code (an empty state included), not only in a scratch harness.
- The 390px render after the final edit shows no horizontal overflow and no covered control.

Adapted from emilkowalski/skills break-ui (MIT); CATALOG.md is adapted from its value catalog and keeps its notice.
