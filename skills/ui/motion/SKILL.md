---
name: motion
description: "Build or review UI motion to a checkable bar: decide whether it should move at all, then property, curve, duration, interruption, exit and reduced motion (small controls 150ms or less, dialogs and drawers 250ms or less, strong ease-out, never ease-in). Review mode scans a diff or codebase for transition-all, ease-in, scale(0), animated layout properties and missing reduced-motion branches, and writes the fix for each. Use when adding, changing or reviewing an animation or transition."
---

Prevents: motion that works but feels slow or cheap (ease-in, scale(0), 300ms+ on small controls), drops frames (width, height, top, transition-all), or ignores reduced motion, which many people run all day.
Use when: building or reviewing any motion in a product UI or a published page.
Not for: deciding a visual design (prototype) or worst-case data (break-ui).

If the repo has its own motion guidelines, their numbers win where they differ from this file.

## The bar
| Element | Duration | Curve |
|---|---|---|
| Press feedback (`:active`) | 100-120ms, `scale(0.97)` | ease-out |
| Hover, tooltip, dropdown, popover | 150ms or less | ease-out |
| Dialog, drawer, sheet | 250ms or less | ease-out to enter, a little faster to exit |
| Moving on screen (reorder, morph) | 150-250ms | ease-in-out |
| Progress, spinners | as long as the work | linear |

- Strong curves: `--ease-out: cubic-bezier(0.23, 1, 0.32, 1)`, `--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1)`. The plain `ease` keyword is too weak for enter and exit.
- Never `ease-in` on UI: it delays the moment the user is watching.
- Never `scale(0)`: start from `scale(0.95)` plus `opacity: 0`.
- Popovers and dropdowns scale from their trigger (`transform-origin` at the trigger edge); dialogs stay centered.
- Animate only `transform` and `opacity`. Width, height, top, left, margin and padding re-lay out the page every frame.

## Build mode
### Step 1: Should it move at all
- Used many times a day (keyboard shortcuts, the command palette, tab switches): no animation. Instant beats smooth.
- Name the purpose in one phrase: feedback, where it came from, state change, or preventing a jarring jump. "Looks nice" on a workspace element is not a purpose; ambient motion stays out of tools people work in.

### Step 2: Pick property, curve and duration from the bar
- Map the change onto transform/opacity. A bar that grows uses `scaleX` with `origin-left`; a level meter uses `scaleY` with `origin-bottom`.
- Name the transitioned properties (`transition-[transform,opacity]`), never `transition-all`.

### Step 3: Make it interruptible and give it an exit
- Use CSS transitions for anything that can be triggered again mid-motion (toggles, toasts); keyframes restart from zero.
- Enter with `@starting-style` (or a mounted flag); every enter has an exit unless the element unmounts instantly by design.
- Framer Motion: pass a full `transform` string, not the `x`/`y`/`scale` shorthands, which run on the main thread.

### Step 4: Reduce Motion branch
- Under `prefers-reduced-motion: reduce`: drop movement and scale, keep a short opacity or color change so feedback survives. Press feedback becomes `filter: brightness(0.94)`.
- Ambient chrome stops entirely; one-shot intentional moments may still play.

### Step 5: Verify on the real path
- Render at 390px twice with Playwright: `reducedMotion: 'no-preference'` and `'reduce'`.
- Run the review-mode scan (below) on every file you touched and fix its hits too, including ones that were there before you: a pre-existing `ease-in` or `transition: all` beside your new motion fails the bar the same way.
- Read the computed style mid-interaction (`getComputedStyle(el).transform` while pressed or open) and capture a frame. A static screenshot does not prove motion.

## Review mode
### Step 1: Scan
```bash
rg -n "transition-all|transition: all|ease-in[^-]|ease-in\"|scale\(0\)|scale-0|transition-\[(width|height|top|left|margin|padding)|duration-(300|500|700|1000)" <path> --glob '*.{tsx,ts,css,html}'
```
Also list each `@keyframes` and check whether it runs on something triggered repeatedly, and every `motion.*` with `x`/`y`/`scale` props.

### Step 2: For each hit, write the fix, not just the problem
- One row per finding: `file:line`, what it does, the replacement line. Show before and after code; when the effect is visible, also show a before and after render.
- Group findings that share a fix ("same fix for the three tab components").

### Step 3: Say what held up
- Note the rules already met (no ease-in, Reduce Motion handled), so the reader knows what not to touch.

## Done when
- Every new or changed animation matches the bar (duration, curve, transform/opacity only, named properties).
- A Reduce Motion branch exists and was rendered under `reducedMotion: 'reduce'`.
- The `Verified:` line cites a mid-interaction computed style or frame at 390px, after the final edit.
- In review mode, every finding carries a concrete before/after fix.

Adapted from emilkowalski/skills review-animations, animate and animation-performance (MIT).
