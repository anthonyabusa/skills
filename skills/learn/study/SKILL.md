---
name: study
description: "Read a source together with the human (a paper, chapter, article or transcript) in a back-and-forth conversation: draw out their reactions and pushback, one question at a time, then write study notes in their own words. Use when someone says 'read this with me', 'let's discuss this paper' or 'help me understand this'."
---

Prevents: a summary dump the reader never engages with, and notes that record what the source said instead of what the reader now thinks.

Use when: the human wants to read, discuss or learn from a specific source and be part of the thinking.
Not for: research you should do alone from many sources (use `research`), or a quick factual answer about the source.

## Step 1: Read the source
- Read the whole thing. A long source goes in chunks, and any part you skipped is named, never silently dropped.
- The source cannot be read (missing file, failed fetch): stop and say so.

## Step 2: Prepare silently
Note for yourself, without showing it: the central claim, the 3-7 key ideas, what backs each, the conclusion, the weak spots (unstated assumptions, ignored counterarguments) and the implications it leaves unexplored. This steers the conversation. It is not the opening message.

## Step 3: Open with a short message
Two to four sentences of plain prose: what you read, your own first impression (convincing? surprising? dense?), and one question that invites them in. No bullet list, and do not restate the argument; they can read it.

If the human is reached through a tool or command rather than your reply, send every question through it and keep the conversation going until they wrap up. Printing the opener and stopping is not a conversation.

## Step 4: Talk it through
- One question per turn, then wait for the answer. Build each turn on what they just said.
- Cover the main ideas in your own words as the conversation reaches them, not in source order.
- Check understanding at the important points. If they are confused, re-explain the idea differently. Do not repeat it louder.
- Ask what they agree with, what they doubt, and whether the evidence holds. Take their pushback seriously. Hold your read where you have reason to, and change it where they are right.
- When they raise an implication you had not seen, follow it.

## Step 5: Wrap up
When they say to wrap up, or the conversation has run its course, say you will write the notes.

## Step 6: Write the notes in their words
Save `notes/study/<YYYY-MM-DD>-<slug>.md`:
```markdown
# <Title>: study notes
Source: <path or URL>
Date: <YYYY-MM-DD>

## What it is about
## Main ideas
## Your take          what you agreed with and why
## Your pushback      what you doubted, with your reasoning
## Implications you raised
## Open questions
```
Write in second person ("You pushed back on..."). Every line under Your take, Your pushback and Implications must trace to something they said. Never put a view in their mouth. If a section has nothing in it, write one line saying so.

Tell them where the file is, and the one point from the conversation that stood out.

## Done when
- The whole source was read, or the skipped parts were named.
- The conversation went one question at a time and reached their own view.
- The notes file exists, with their take and pushback in their own reasoning.
