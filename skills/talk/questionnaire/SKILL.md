---
name: questionnaire
description: Write a structured set of questions for someone else who holds the answers (a client, teammate, stakeholder), aimed only at what is not already known, for the human to send. Use when progress is blocked on knowledge held by a third party; not for questions to the human you are working with.
---

Prevents: sending unstructured, redundant, or credibility-damaging questions.

Use when:  
- Progress is blocked on facts, preferences, or decisions held by someone other than the human you are working with.  
- The move is to send a structured set of questions (not a single quick question).  
- The recipient is a client, stakeholder or teammate.

Not for:  
- Questions to the human you are working with (just ask them).  
- Single quick questions (just write them).  
- Anything research can answer from sources (use research).

## Step 1: Settle the send, not the content  
Ask the human (one batch, AskUserQuestion in Claude Code, recommended defaults) only what you cannot infer:  
- Who receives it (role, not name).  
- What we need back and by when.  
- The channel (email, chat, issue tracker, form).  
- Whose name it goes out under.  
Everything else is your call.

## Step 2: Match the sender's voice  
If it goes out under the human's name and a voice or style guide exists, load it and draft against it. Either way: no filler opener, no rhetorical questions, plain words.

## Step 3: Find the gap  
Write down what is already known (the repo, the project notes, prior threads) and what is not.  
Every question must close part of the gap.  
Never ask for something already known, it costs goodwill and credibility.

## Step 4: Draft  
Template, in order:  
1. **Purpose**: Why we're asking and what answers change.  
2. **From / to**: Sender and recipient roles.  
3. **Context**: Only what they need; link, don't paste.  
4. **How to answer**: Format, rough time (aim <15 min), deadline, "skip anything you don't know."  
5. **Questions**: Under a short heading per theme (for example `Backups`, `Access`), most important theme first; a flat numbered list is not grouped.  
   - One idea per question.  
   - No compound "and/or."  
   - Explicit choices or an example answer; a bare `Answer:` only for the catch-all.  
   - A few words on what the answer decides, on every question.  
   - The recipient's words. For a non-technical recipient, describe each thing by what it does for them, not by its computer name: no acronyms, units or terms they did not use themselves.  
6. **Catch-all**: "Anything we should have asked and didn't?"

Keep money, credentials and other people's personal details out of anything you save or commit.

## Step 5: Hand it over  
Output:  
- Label it `DRAFT: do not send`.  
- Put the whole body in one copyable code block. Each paragraph, each question and each answer stub sits on one unbroken line (no hard wraps inside a line), so it pastes cleanly into email or chat.  
- Never send it yourself: sending is external and the human's call.  
- Worth keeping: save it as `docs/questionnaires/<date>-<recipient-role>.md`.

## Done when
- The send details (recipient role, what is needed back and by when, channel, sender) were settled with the human, asking only what could not be inferred.
- Every question closes a named gap; none asks for something already known, a secret or a password.
- The draft follows the template order, and every question has an answer stub or explicit choices.
- The questions sit under theme headings.
- It was handed over labelled `DRAFT: do not send`, in one copyable code block, and was not sent.

Adapted from mattpocock/skills to-questionnaire (MIT).
