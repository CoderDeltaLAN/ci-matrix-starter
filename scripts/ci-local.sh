#!/usr/bin/env bash
set -euo pipefail

echo "→ Node setup"
if [ -f package.json ]; then
  npm ci --ignore-scripts --fund=false
  npm run -s format:check || (echo "Prettier failed" && exit 1)
  npm run -s lint || (echo "ESLint failed" && exit 1)
  npm run -s typecheck || (echo "tsc failed" && exit 1)
  echo "→ Node smoke"
  node -e "console.log('node ok')"
fi

echo "→ Python setup"
if command -v poetry >/dev/null 2>&1; then
  poetry install --no-interaction
  poetry run ruff check .
  poetry run black --check .
  PYTHONPATH=src poetry run pytest -q
  poetry run mypy src
else
  python -m pip install --upgrade pip
  pip install ruff black pytest mypy
  ruff check .
  black --check .
  PYTHONPATH=src pytest -q
  mypy src
fi

echo "→ Python smoke"
python - <<'PY'
try:
    import ci_matrix_starter as m
    print("py ok:", getattr(m, "__version__", "0"))
except Exception as e:
    print("py smoke failed:", e); raise
PY

echo "✅ Local checks passed"
