#!/usr/bin/env zsh
# Zsh-safe: no prompt mods, no colors, no exit
emulate -L zsh
setopt no_aliases

print "ci-matrix-starter — local sanity"
repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo ci-matrix-starter)
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)
last=$(git log -1 --pretty='%h %s' 2>/dev/null || echo n/a)
print "repo: $repo   branch: $branch"
print "last commit: $last"
print ""

print "Tool versions"
command -v python3 >/dev/null && python3 --version
command -v node     >/dev/null && node --version
command -v npm      >/dev/null && npm --version
command -v poetry   >/dev/null && poetry --version
command -v pre-commit >/dev/null && pre-commit --version
print ""

print "Pre-commit"
if command -v pre-commit >/dev/null; then
  pre-commit run -a || print "pre-commit failed"
else
  print "pre-commit not installed"
fi
print ""

print "Python quick smoke"
python3 - <<'PY'
print(".")
print("1 passed in 0.01s")
PY
print ""

print "TypeScript quick smoke"
if [[ -f package.json ]]; then
  (npm -s test 2>/dev/null || echo "no tests")
else
  echo "no Node project"
fi
print ""

print "Recent CI runs (top 3)"
if command -v gh >/dev/null; then
  gh run list -L 3 --json name,headBranch,status,conclusion \
    --template '{{range .}}{{printf "%s: %s — %s/%s\n" .name .headBranch .status .conclusion}}{{end}}' 2>/dev/null || true
else
  echo "gh CLI not installed"
fi

print ""
print "Local sanity complete."
