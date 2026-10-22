---
name: mobile-native
description: "Make a web app feel installed on a phone, not like a website: sticky hover after tap, tap flash, the 100vh bug, inputs that zoom the page, laggy taps, pull-to-refresh hijacking an app scroll, content under the notch, long-press selecting button text, carousels scrolling the wrong axis, status bar color. Never by disabling zoom. Use when a web app or PWA works on desktop but feels wrong on a phone."
---

Prevents: phone bugs that desktop emulation hides, and the wrong fixes people reach for (disabling zoom, sniffing user agents).
Use when: building or fixing any web surface people use on a phone.
Not for: choosing what to build (prototype) or how it moves (motion).

## Rules
- Every fix carries its reason; apply it where the reason holds, not globally. `user-select: none` on a button is right, on body text it is a defect.
- Gate by capability (`@media (hover: hover)`, `env()`, `dvh`), never by user agent or screen width.
- **Never disable zoom.** Remove `user-scalable=no` and `maximum-scale=1` if present; fix the cause (input font size) instead.

## Step 1: Find the symptom, apply its fix
| Symptom | Fix |
|---|---|
| Page zooms when an input is focused | inputs, selects and textareas at 16px or larger (`font-size: max(16px, 1rem)`) |
| Bottom cut off behind the browser toolbar | full-height shells use `100dvh` (fallback `100vh` first), not bare `100vh` |
| Hover style sticks after a tap | wrap hover rules in `@media (hover: hover) and (pointer: fine)` |
| Gray or blue flash on tap | `-webkit-tap-highlight-color: transparent` on interactive elements, with a visible `:active` state in its place |
| Tap feels laggy | `touch-action: manipulation` on buttons and links |
| Content under the notch or home bar | `viewport-fit=cover` in the viewport meta, then `env(safe-area-inset-*)` padding on fixed headers, footers and bars |
| Pull-to-refresh or page bounce fights an app shell | `overscroll-behavior: none` on `html, body` only for app-like shells; `contain` on inner scrollers (sheets, chat lists). Leave documents alone |
| Long-press selects button text | `user-select: none; -webkit-touch-callout: none` on controls only |
| Horizontal carousel drags the page vertically | `touch-action: pan-y` on the track plus `scroll-snap-type: x mandatory` |
| Status bar color clashes | `<meta name="theme-color">` per `prefers-color-scheme` |

## Step 2: Check the baseline
Even if only one symptom was reported, scan the page for the other rows (viewport meta, input sizes, `100vh`, ungated `:hover`) and fix what applies. Say which rows you skipped and why.

## Step 3: Verify at 390px
Render with Playwright at 390x844 with `isMobile: true, hasTouch: true`, in both themes: no horizontal overflow, focused input computes 16px or more, the last element clears the bottom inset. Emulation cannot show sticky hover, tap delay, rubber-banding or the real keyboard: list those for someone to check on a real phone.

## Done when
- Each reported symptom has its fix in the diff, with the reason in the report.
- No zoom-disabling viewport, no ungated `:hover` that changes layout or color, no bare `100vh` on a full-height shell.
- The 390px render passed; hardware-only behaviors are named for a phone check.

Adapted from emilkowalski/skills mobile-native (MIT).
