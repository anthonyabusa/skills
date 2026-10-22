---
name: prototype
description: "Build three to five genuinely different directions for one UI piece behind a live picker, so the person deciding can flip through them, on a phone too, and promote one. Each direction differs on a named axis (layout, density, interaction model, motion), never three tints of one idea. Use when asked for options, directions or variants of a UI before committing to one."
---

Prevents: options that converge into one idea in three colors, and prototypes that leak into shipping code.
Use when: the direction is open and seeing it beats describing it.
Not for: a direction that is already decided.

## Step 1: Scope the brief
One UI piece. Restate what it is, where it lives and what it must do in one sentence. If the ask spans several pieces, pick the one that matters most and say so.

## Step 2: Read the ground
Stack, tokens (colors, radii, spacing, type, motion), the surface's personality (its design guidelines, if the repo has them), and what sits around the piece. Variants use the real tokens; only the picker chrome is neutral.

## Step 3: Pick divergent directions
- Three by default, up to five when the space is wide. Each gets a name ("Ledger", "Cards", "Timeline"), not "Option A", and one named axis it explores.
- Two variants that differ only in color, copy or spacing are one variant: drop or rethink one.

## Step 4: Build behind the picker
- Repo with a router: an isolated route (`/prototypes/<slug>`), one file per variant plus the harness. Static: one self-contained HTML file.
- Use PICKER.md's markup, styles and wiring as given; mark each variant root `data-variant="<name>"`.
- One variant renders at a time, full size, in realistic context with realistic data. Flipping (1-N, arrow keys, `?v=` in the URL) swaps instantly and remounts the variant.
- It must work at 390px: people often judge on a phone.
- Never touch the shipping component; prototypes live beside it.

## Step 5: Verify and hand off
- Flip through every variant at 390px and desktop width with Playwright, both themes: renders, no console errors.
- Put it somewhere the reviewer can open on a phone: a preview deploy, or the local URL if they are at the machine.
- Report a table: variant, axis, when it is the right choice, its cost. Then a recommendation with one line of why; the reviewer picks.
- Say where it lives and how to flip.

## Done when
- At least three variants that differ in structure, each reachable in the picker with no console errors at 390px.
- The shipping UI is unchanged.
- The table, the recommendation and the review link reached the reviewer.

Adapted from emilkowalski/skills prototype (MIT); PICKER.md is copied from it and keeps its notice.
