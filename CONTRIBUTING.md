# Contributing

## Workflow

- PRs con squash-merge. Nada directo a main.
- Árbol verde local antes de subir. CI verde antes de merge.

## Local radar

# opción 1

scripts/ci-local.sh

# opción 2

pre-commit run -a
actionlint -no-color
poetry run pytest -q && npm test

## Estilo

- Python: ruff + black.
- Node/TS: prettier + eslint + tsc --noEmit.

## Seguridad

- No secretos. Supply chain: arreglar raíces vulnerables, regenerar lock, verificar SBOM.
