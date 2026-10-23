---
name: verify-ui
description: "Prove a UI change works before calling it done: render it after the last edit, at the width the problem was reported at, look at the exact element, check motion under Reduce Motion, and click every control in scope to confirm it does something. Use before reporting any frontend fix or feature as done, or when a human says a fix you reported still looks broken."
---

Prevents: "fixed" UI that is still broken on the human's device. The usual causes: a screenshot taken before the last edit, a desktop render for a phone bug, an evidence image that still shows the defect, an animation checked only with motion on, and a button that renders but does nothing.

Use when: a change touched HTML, CSS, a component or a screen, and you are about to say it is done.
Not for: backend-only changes, or a copy edit with no layout effect.

## Step 1: Pin down what "fixed" means
- Write one line per reported problem: the element, what is wrong, and the width it was seen at. A phone report with no width means 390px. No width at all means check 390px and 1280px.
- List every control in scope: each button, link, toggle, form or tap target on the changed element or on the flow the request names. The element the human reported is always in scope, so if it is a control, it must work as well as look right.

## Step 2: Render after the last edit
- Make your final edit first. Then render. A screenshot from before the last edit proves nothing, so re-render after every further change.
- Use a real browser. With Playwright:
  ```python
  from playwright.sync_api import sync_playwright
  with sync_playwright() as p:
      b = p.chromium.launch()
      pg = b.new_page(viewport={"width": 390, "height": 844})
      pg.goto("file:///abs/path/index.html")   # or the dev server URL
      pg.screenshot(path="verify-390.png", full_page=True)
  ```
- Render at every width from Step 1.
- No browser can run here: say so, and report the change as not verified. Never fill the gap with a guess.

## Step 3: Look at the exact element
- Open each screenshot and find the reported element. Is it fixed? Answer yes or no, with what you see.
- Back the eye with a measurement where one exists. For overflow, check that the element's right edge is within the viewport (`el.getBoundingClientRect().right <= innerWidth`). For hidden or clipped text, compare `scrollWidth` with `clientWidth`.
- If the image still shows the defect, the fix failed. Go back to the code.

## Step 4: Motion under Reduce Motion
If the change adds or alters an animation or transition, render again with `reduced_motion="reduce"` on the browser context. Confirm the motion is removed or reduced and nothing breaks without it, for example content that only appears through an animation.

## Step 5: Exercise every control
A screenshot proves a control is drawn, not that it works. For each control from Step 1:
- Click or tap it (`pg.click(...)`; use a mobile viewport for a phone surface).
- Assert the effect the user expects: the item went away, the count changed, the menu opened, the request returned 2xx, the page navigated.
- A control with no effect is a bug. If it is part of what you were asked to fix or build, fix it and exercise it again. If it is outside the request, report it plainly as broken. Never pass it as working.

## Step 6: Report
Put the evidence in the done message:
```
Verified: rendered at 390px and 1280px after the last edit (verify-390.png, verify-1280.png)
Element: <the reported element> now <what you saw / measured>
Motion: checked with Reduce Motion on | no motion changed
Controls: <control> -> <effect observed>, one per control
Not verified: <anything you could not check, and why>
```

## Done when
- Every reported problem was checked in a render taken after the last edit, at the reported width, and is fixed.
- Motion changes were checked under Reduce Motion.
- Every control in scope was exercised and its effect observed, or it is reported as broken.
- The done message carries the evidence block, including anything not verified.
