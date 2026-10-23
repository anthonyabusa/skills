---
name: secret-sweep
description: "Before a commit or push, sweep everything local for secrets: staged and unstaged changes, untracked files, and commits not yet pushed. Report each hit by file and line without printing the value, and stop the commit until it is removed. Use after work that touched auth, API keys, tokens, .env or config files, or when a key may have been pasted somewhere."
---

Prevents: a pasted key or a dropped-in `.env` becoming a commit. A diff-only scan misses untracked files, and a push-time scan only sees what is already committed; by then the key has to be rotated.

Use when: the work touched credentials, provider setup, `.env` or config files, or before a commit or push in a repo that holds any secrets.
Not for: a full security audit of the code (this checks for leaked values, not vulnerabilities).

## Step 1: Collect the local working set
```bash
git diff --cached --name-only                         # staged
git diff --name-only                                  # unstaged
git ls-files --others --exclude-standard              # untracked, not ignored
git log --name-only --format= @{upstream}..HEAD 2>/dev/null | sort -u   # committed, not pushed
```
Untracked files matter most: `git diff` never shows them, and any `git add -A` or auto-commit would sweep them in.

## Step 2: Flag credential files
Any path in the set matching `.env`, `.env.*` (except `.env.example`), `*.pem`, `*.key`, `id_rsa*`, `credentials*`, `*secret*`, `*.p12` or `*.keystore` is a credential file. Also check `.gitignore`: a credential file that is not ignored is a finding even when it looks empty.

## Step 3: Scan contents for secret values
Scan the changed lines (`git diff --cached -U0`, `git diff -U0`, the unpushed commits' `git log -p`) and the full content of untracked files:
```bash
grep -nE '(AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9_-]{20,}|sk_live_[0-9a-zA-Z]{20,}|ghp_[A-Za-z0-9]{36}|xox[bp]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|(api[_-]?key|secret|token|password)["'"'"']?\s*[:=]\s*["'"'"']?[A-Za-z0-9/+_.-]{16,})' <file>
```
Treat a placeholder (`changeme`, `xxx`, `<your-key>`, `${VAR}`, `os.environ[...]`) as clean. Treat a real-looking value as a hit even if the variable name says test.

## Step 4: Report without leaking
- One line per hit: `path:line  <kind>  <first 4 characters>…`. Never print the full value, in chat, logs or the report.
- Verdict: **FAIL** (at least one value hit), **WARN** (a credential file is in the set but no value matched; open it and check), or **PASS**.

## Step 5: Fix before anything ships
On FAIL, do not commit or push.
- **Still local:** move the value out (to an ignored `.env` or a secret store), reference it by name, and add the file to `.gitignore`.
- **Committed but not pushed:** remove it and rewrite the local commits (amend or interactive rebase) before pushing.
- **Pushed, or pasted anywhere outside the machine:** treat it as burned. Tell the human to rotate or revoke it now; removing it from history does not un-leak it.
Re-run the sweep until it passes.

## Done when
- All four parts of the working set were scanned, untracked files included.
- Every hit is reported by path and line with the value masked, and the verdict is stated.
- Nothing with a FAIL verdict was committed or pushed, and any key that left the machine was flagged for rotation.
