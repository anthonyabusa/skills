---
name: plainly
description: Re-explain the last message in plain, simple English when it did not land. Use short sentences, one idea each, active voice, present tense. No new jargon, no metaphors. Define terms in five words or fewer. Use when an explanation did not land ("wait what", "I don't follow", "explain simply"). Keep shorter than the original.
---

Prevents: Misunderstandings when technical or dense language fails to land.

Use when:  
- The human says 'wait what', 'I don't follow', 'explain simply', 'in plain English', 'ELI5'.  
- The last message used jargon, complex structure, or abstract terms that didn't connect.  
- A concrete example would clarify better than rephrasing.

Not for:  
- Requests for more depth or detail (answer those directly).  
- Explaining something not yet covered.  
- Repeating the same message in the same style.

1. Identify the core idea that failed to land.  
2. Lead with a one-sentence answer: what it is or what happens.  
3. Break down into short, active-voice sentences. One idea per sentence.  
4. Use the repo's own terms (from `GLOSSARY.md` if there is one). Define any new term in five words or fewer.  
5. Replace abstractions with concrete examples: name the actual file, task, or command.  
6. If order matters, use a numbered list. Otherwise, use prose.  
7. Keep the rewrite shorter than the original message.  
8. Reply in this shape, nothing before or after it:
   - First line: the direct answer to what they asked.
   - Then the plain explanation.
   - The reply itself carries the answer and the explanation, even when you also save a file. A reply that only says where it saved is not an answer.
   - Then `Saved: <path>`, only if you saved a file.
   - Last line: `Next: <one action>`, only if there is one.

## Done when:  
- The explanation uses plain, simple English.  
- Each sentence conveys one clear idea.  
- No new jargon or metaphors are introduced.  
- The length is shorter than the original.  
- The human can act or decide without follow-up.
- The reply follows the shape: answer first, one `Next:` line last.

Adapted from mattpocock/skills wait-what (MIT).
