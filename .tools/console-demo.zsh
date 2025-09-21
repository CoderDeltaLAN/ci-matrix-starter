#!/usr/bin/env zsh
set -e
autoload -Uz colors && colors

print -P "\n%F{45}%Bci-matrix-starter — local sanity%b%f"
print -P "%F{241}repo:%f $(basename $PWD)   %F{241}branch:%f $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo n/a)"
print -P "%F{241}last commit:%f $(git log -1 --pretty='%h %s' 2>/dev/null || echo n/a)"

echo; print -P "%F{45}%BTool versions%b%f"
python3 -V || true
node -v || true
npm -v || true
poetry --version 2>/dev/null || true
pre-commit --version 2>/dev/null || true

echo; print -P "%F{45}%BPre-commit%b%f"
pre-commit run -a || true

echo; print -P "%F{45}%BPython quick smoke%b%f"
PYTHONPATH=src poetry run pytest -q --maxfail=1 2>/dev/null || echo "(pytest not configured or tests skipped)"

echo; print -P "%F{45}%BTypeScript quick smoke%b%f"
npx --yes tsc --noEmit 2>/dev/null || echo "(tsc not configured)"
npm test --silent 2>/dev/null || echo "(no npm tests)"

if command -v gh >/dev/null; then
  echo; print -P "%F{45}%BRecent CI runs (top 3)%b%f"
  gh run list -L 3 --json status,conclusion,workflowName,displayTitle \
    --jq '.[] | "\(.workflowName): \(.displayTitle) — \(.status)/\(.conclusion)"' || true
fi

print -P "\n%F{70}Ready — take the screenshot now.%f\n"
