#!/usr/bin/env bash
# Fail if the repo contains secrets, private IPs or money amounts, plus any private terms you list.
# Usage: scripts/leak-scan.sh [path]   (default: repo root).
# Add your own private terms (internal names, hosts) in a file OUTSIDE the repo and point LEAK_DENYLIST at it, one regex per line.
set -euo pipefail
root="${1:-$(git rev-parse --show-toplevel)}"
pat='192\.168\.|10\.0\.|\.local\b|\$[0-9][0-9,]*|sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|xox[bp]-|AKIA[0-9A-Z]{16}|BEGIN [A-Z ]*PRIVATE KEY'
[ -n "${LEAK_DENYLIST:-}" ] && [ -f "$LEAK_DENYLIST" ] && pat="$pat|$(grep -v '^#' "$LEAK_DENYLIST" | paste -sd'|' -)"
# The repo's own install handle is allowed. LICENSE, the notices and the plugin manifests legitimately carry the copyright holder's name.
hits=$(grep -rIniE "$pat" "$root" --exclude-dir=.git --exclude=LICENSE --exclude=leak-scan.sh --exclude=THIRD_PARTY_NOTICES.md --exclude-dir=.claude-plugin | grep -vE 'scripts/leak-scan\.sh|anthonyabusa/skills|skills@anthonyabusa|github\.com/anthonyabusa\b' || true)
if command -v gitleaks >/dev/null; then gitleaks detect --source "$root" --no-banner --redact || exit 1; fi
if [ -n "$hits" ]; then echo "$hits"; echo "leak-scan: FAIL ($(echo "$hits" | wc -l | tr -d ' ') hits)"; exit 1; fi
echo "leak-scan: clean"
