---
name: research
description: Turn a research question into a dated, sourced answer with confidence; validate every claim against primary sources (docs, code, specs) before use. Use when picking a library, verifying an API behavior, or resolving a technical doubt with evidence.
---

Prevents: decisions based on assumptions, outdated docs, or unsourced claims.

Use when:
- Choosing between libraries or patterns and need evidence on support, stability, or best practices.
- Verifying how an API, framework, or spec actually works, beyond memory or summaries.
- Resolving conflicting information from multiple sources.

Not for:
- General knowledge already confirmed and documented.
- Tasks that don't require primary source validation.
- Situations where speed is prioritized over evidence.

1. Frame the question and the decision it feeds.
   - Example: "Q: Does React 18 support streaming SSR? Feeds: adopt it in the export feature."
   - Reject open-ended or decision-less research.

2. Rank sources by reliability.
   - Prefer: official docs, source code, specs, release notes.
   - Downgrade: blogs, forums, model memory.
   - Read the full page, search snippets are not sources.

3. Resolve conflicts between sources.
   - If sources disagree, state the conflict.
   - Choose the most authoritative (e.g., code over docs, newer release over older).
   - Document the rationale.

4. Date findings and the versions checked.
   - Findings expire when versions change.
   - Include the check date and the exact versions you ran (print them, e.g. `python3 --version`, and copy the output).

5. End with a clear answer, confidence level (high, medium, low), and what evidence would change it.
   - Example: "Answer: Yes. Confidence: high. Evidence: React 18 release notes + source."
   - If inconclusive, summarize unknowns.
   - In the reply, give the answer with the version you ran and the `Not tested:` line, so the human sees the limit without opening the file.

6. Validate every claim against primary sources.
   - Open each cited URL or repo path:line.
   - Confirm the excerpt supports the claim.
   - Drop or re-source unsupported claims.
   - Never invent a source.

7. Save valid findings to `docs/research/<YYYY-MM-DD>-<slug>.md`, starting with these lines:
   - `Question:` / `Answer:` / `Confidence: high | medium | low`
   - `Checked: <date>, <exact versions you ran>` / `Not tested: <versions you did not run, e.g. Python 3.8 to 3.12>` / `Sources:`
   - Use the date and topic in the filename.
   - Do not save until all claims are verified.

8. Present findings with source check status.
   - If unverified (e.g., network down), state which sources are unverified.
   - Never present unsupported claims as fact.

## Done when:
- The answer is clear, sourced, and tied to a decision.
- Every claim has been validated against a primary source.
- Confidence and expiry are stated.
- Findings are saved (if applicable) with a verification stamp.
- The saved file has the `Confidence:`, `Checked:` and `Not tested:` lines, and the reply repeats `Not tested:`.

Sourcing discipline adapted from mattpocock/skills research (MIT).
