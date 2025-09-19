<p align="center">
  <a href="https://securityscorecards.dev/viewer/?uri=github.com/CoderDeltaLAN/ci-matrix-starter">
    <img alt="OpenSSF Scorecard" src="https://api.securityscorecards.dev/projects/github.com/CoderDeltaLAN/ci-matrix-starter/badge" />
  </a>
  <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/supply-chain.yml">
    <img alt="Supply-chain" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/supply-chain.yml/badge.svg" />
  </a>
  <a href="https://pypi.org/project/ci-matrix-starter/">
    <img alt="PyPI" src="https://img.shields.io/pypi/v/ci-matrix-starter?logo=pypi" />
  </a>
  <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/py-ci.yml">
    <img alt="Python CI (reusable)" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/py-ci.yml/badge.svg" />
  </a>
</p>

# ⭐ ci-matrix-starter — Reusable CI Workflows (Python & TypeScript)

A lean, production-ready **GitHub Actions starter** that ships **reusable CI workflows** for **Python (3.11/3.12)** and **TypeScript/Node 20**.
It’s designed for **always-green CI** with strict local gates mirroring CI, **CodeQL** out of the box, optional **SBOM** generation, and guard-rails for safe merges (branch protection + required checks).

<div align="center">

[![CI / build](https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/build.yml)
[![CodeQL Analysis](https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/codeql.yml)
[![Release](https://img.shields.io/github/v/release/CoderDeltaLAN/ci-matrix-starter?display_name=tag)](https://github.com/CoderDeltaLAN/ci-matrix-starter/releases)
![Python 3.11|3.12](https://img.shields.io/badge/Python-3.11%20|%203.12-3776AB?logo=python)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW)

</div>

---

## Repo layout

```text
.
├── .github/workflows/
│   ├── build.yml                 # Aggregator: calls reusable jobs (TS & Py)
│   ├── ts-ci.yml                 # Reusable TypeScript/Node CI
│   └── py-ci.yml                 # Reusable Python CI
├── src/
│   ├── index.ts                  # minimal TS sanity (example)
│   └── ci_matrix_starter/        # minimal Py package (example)
├── tests/                        # Python tests (example)
├── package.json                  # Node project (example scripts)
├── pyproject.toml                # Python tooling (ruff/black/pytest/mypy)
└── README.md
```

---

## 🚀 Quick Start (consumers)

<!-- ci-matrix-starter:usage:start -->

### Use the reusable workflows in _your_ repo

Create `.github/workflows/ci.yml` in your project:

```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]

jobs:
  # Python matrix (3.11/3.12) with strict gates
  py:
    uses: CoderDeltaLAN/ci-matrix-starter/.github/workflows/py-ci.yml@v0.1.0
    with:
      py-versions: '["3.11","3.12"]'
      cov-min: 100

  # TypeScript / Node 20
  ts:
    uses: CoderDeltaLAN/ci-matrix-starter/.github/workflows/ts-ci.yml@v0.1.0
```

> Tip: the **aggregator** in this repo (`build.yml`) is a reference showing how to orchestrate multiple reusable jobs.

### Local mirror (same gates as CI)

**Node / TS**

```bash
npx prettier --check .
npx eslint . --max-warnings=0
npx tsc --noEmit
npm test --silent
```

**Python**

```bash
python -m pip install --upgrade pip
pip install poetry
poetry install --no-interaction
poetry run ruff check .
poetry run black --check .
PYTHONPATH=src poetry run pytest -q --cov=src --cov-fail-under=100
poetry run mypy src
```

<!-- ci-matrix-starter:usage:end -->

> Nothing in your shell needs to change. Consume the workflows by reference (`uses:`) and keep your repo clean.

---

## 📦 What the workflows expect

**TypeScript**

- `package.json` with `test` script (any test runner).
- `tsconfig.json` limiting sources (e.g., `src/**/*.ts`).
- `eslint.config.mjs` (flat config) and **Prettier 3**.
- Node **20.x** recommended.

**Python**

- `pyproject.toml` with dev tools (**ruff**, **black**, **pytest**, **mypy**, **poetry**).
- Tests under `tests/`; coverage threshold via `cov-min` input (default in example: `100`).
- Matrix **3.11/3.12** (customizable via `py-versions`).

**Optional SBOM & signing**

- Workflows can export SBOMs (CycloneDX). If you set `COSIGN_KEY` & `COSIGN_PASSWORD` as secrets, signing will be attempted (safe-by-default: skipped when absent).

---

## ⛳ Required checks (CI gating)

Typical required contexts (suggested for branch protection):

- `CI / build` (aggregator success)
- `CodeQL Analyze / codeql` (security)

Enable linear history, dismiss stale reviews on new pushes, and auto-merge once checks are green for a professional, low-friction flow.

---

## 🧪 Local Developer Workflow (mirrors CI)

```bash
# Node
npx prettier --check . && npx eslint . --max-warnings=0 && npx tsc --noEmit && npm test --silent

# Python
python -m pip install --upgrade pip && pip install poetry
poetry install --no-interaction
poetry run ruff check . && poetry run black --check .
PYTHONPATH=src poetry run pytest -q --cov=src --cov-fail-under=100
poetry run mypy src
```

---

## 🔧 CI (GitHub Actions)

- Reusable jobs for **Python** and **TypeScript**; call them from your repo via `uses:` with a tag (e.g., `@v0.1.0`).
- Built-in **CodeQL** workflow example.
- Strict, fast feedback suitable for PR auto-merge when green.

Python job snippet recap:

```yaml
- run: python -m pip install --upgrade pip
- run: pip install poetry
- run: poetry install --no-interaction
- run: poetry run ruff check .
- run: poetry run black --check .
- env:
    PYTHONPATH: src
  run: poetry run pytest -q
- run: poetry run mypy src
```

TypeScript job snippet recap:

```yaml
- run: npx prettier --check .
- run: npx eslint . --max-warnings=0
- run: npx tsc --noEmit
- run: npm test --silent || echo "no tests"
```

---

## 🗺 When to Use This Project

- You need **ready-to-use CI** for **Python + TypeScript** with clean defaults.
- You want **reusable workflows** you can reference by tag.
- You value **security** (CodeQL), **SBOMs**, and **strict gates** to keep `main` always green.

---

## 🧩 Customization

- Pin a release tag, e.g., `@v0.1.0`.
- Adjust Python matrix: `with.py-versions`.
- Tune coverage: `with.cov-min`.
- Provide secrets to enable optional **cosign** signing.
- Extend jobs by adding your own steps after `uses:` blocks.

---

## 🔒 Security

- Code scanning via **CodeQL**.
- Recommend enabling: **required conversations resolved**, **dismiss stale reviews**, **signed commits**, and **squash merges**.
- Avoid uploading sensitive artifacts to public PRs.

---

## 🙌 Contributing

- Small, atomic PRs using **Conventional Commits**.
- Keep local & CI gates green before requesting review.
- Use auto-merge once checks pass.

---

## 💚 Donations & Sponsorship

If this project saves you time, consider supporting ongoing maintenance. Thank you!
[![Donate](https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white)](https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW)

---

## 🔎 SEO Keywords

reusable github actions workflows, python typescript ci starter, node 20 eslint 9 prettier 3, ruff black mypy pytest, cycloneDX sbom cosign signing, codeql security analysis, branch protection auto merge, always green ci, monorepo friendly ci, strict local gates mirror

---

## 👤 Author

**CoderDeltaLAN (Yosvel)**
GitHub: https://github.com/CoderDeltaLAN

---

## 📄 License

Released under the **MIT License**. See [LICENSE](LICENSE).
