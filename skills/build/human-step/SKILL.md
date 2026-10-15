---
name: human-step
description: Turn a step only a human can do (a console click, an OAuth app setup, an API key, a physical action) into exact instructions plus a verify probe, so the blocker clears on evidence and no secret passes through chat. Use when a task is blocked on something the agent cannot do itself.
---

Prevents: vague "please set up X" asks, secrets pasted into chat, and blockers marked cleared when the step was never actually done.

Use when: a task is blocked on a human-only action: signing in to a console, creating an app or key, approving a payment, plugging something in.
Not for: decisions (use question-first), or anything the agent can do itself.

## Step 1: Write the exact steps
- One action per numbered line: the URL, the menu path, the button label, the value to enter.
- Take URLs, ids and names from the repo's real config (env files, settings, existing code). Never guess them.
- Say what the human should see when it worked (a status, a page, a file).

## Step 2: Route the secret around the chat
If the step produces a secret (a key, a token, a private key file):
- Tell the human where to put it directly: a local, git-ignored file with mode 0600 (`chmod 600 <file>`), or the OS keychain, or the platform's secret store.
- Name the exact path or key name the code already reads. Never ask them to paste it into the conversation.
- If it does arrive in chat anyway, say so, and recommend rotating it.

## Step 3: Write the verify probe
A command that exits 0 only when the step truly succeeded:
- best: a real call with the new credential returns success (an API request returning 200, a CLI `whoami`);
- acceptable: the file exists, parses, and has the expected fields and permissions;
- never: "the human said done".
Run the probe once now and confirm it fails, so you know it can tell the difference.

## Step 4: Hand it over
Give the human the steps and the one probe command together. Then wait; do not mark anything unblocked yet.

## Step 5: Verify, then unblock
- Run the probe. Green: set the task back to `todo` in the task store and add the probe output as evidence. Then do any agent-side follow-up the step enabled.
- Red: keep it blocked, show the probe output, and fix the instructions or the probe.

## Done when
- The probe exits 0 on the real result, and its output is recorded on the task.
- No secret appeared in the conversation, or one did and rotation was recommended.

Adapted from mattpocock/skills wizard (MIT).
