#!/usr/bin/env bash
# Radar local estándar. Sin set -e.
repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || exit 1
cd "$repo_root" || exit 1

# Pre-commit + workflows
pre-commit run -a || exit $?
if command -v actionlint >/dev/null 2>&1; then
  actionlint -no-color || exit $?
elif [ -x .tools/actionlint/actionlint ]; then
  .tools/actionlint/actionlint -no-color || exit $?
fi

# Python
if [ -f pyproject.toml ]; then
  poetry install --no-interaction || exit $?
  poetry run ruff check . --fix || exit $?
  poetry run ruff format . || exit $?
  poetry run black . || exit $?
  poetry run pytest -q || exit $?
  poetry run mypy . || true
fi

# Node/TS
if [ -f package.json ]; then
  npm ci || exit $?
  npx prettier -c . || exit $?
  npx eslint --max-warnings=0 . || exit $?
  npx tsc --noEmit || true
  npm test || exit $?
  npm pack --dry-run || exit $?
fi

echo "Radar local OK"
