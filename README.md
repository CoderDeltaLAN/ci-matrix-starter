# ⭐ **ci-matrix-starter — Reusable CI Workflows (Python & TypeScript)**

A lean, production-ready **GitHub Actions starter** that ships **reusable CI workflows** for **Python (3.11/3.12)** and **TypeScript/Node 20**.
Designed for **always-green CI** with strict local gates mirroring CI, **CodeQL** out of the box, optional **SBOM** generation, and guard-rails for safe merges.

<!-- BADGES:FOOT:BEGIN -->
<div align="center">

  <div><sub><b>**Core status**</b></sub></div>
  <p>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/build.yml">
      <img alt="CI" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/build.yml/badge.svg?branch=main&label=CI" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/codeql.yml">
      <img alt="CodeQL Analyze" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/codeql.yml/badge.svg?branch=main&label=CodeQL%20Analyze" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/releases">
      <img alt="release" src="https://img.shields.io/github/v/release/CoderDeltaLAN/ci-matrix-starter?display_name=tag&label=release" />
    </a>
    <img alt="Python 3.11 | 3.12" src="https://img.shields.io/badge/Python-3.11%20%7C%203.12-3776AB?logo=python" />
    <a href="LICENSE">
      <img alt="License MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
    </a>
  </p>

  <div><sub><b>**CI & automation**</b></sub></div>
  <p>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/py-ci-badge.yml">
      <img alt="Python CI (reusable)" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/py-ci-badge.yml/badge.svg?branch=main&label=Python%20CI%20(reusable)" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/ts-ci-badge.yml">
      <img alt="TS CI (reusable)" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/ts-ci-badge.yml/badge.svg?branch=main&label=TS%20CI" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/auto-assign-badge.yml">
      <img alt="auto-assign" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/auto-assign-badge.yml/badge.svg?branch=main&label=auto-assign" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/pr-labeler-badge.yml">
      <img alt="pr-labeler" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/pr-labeler-badge.yml/badge.svg?branch=main&label=pr-labeler" />
    </a>
  </p>

  <div><sub><b>**Security &amp; supply-chain**</b></sub></div>
  <p>
    <a href="https://securityscorecards.dev/viewer/?uri=github.com/CoderDeltaLAN/ci-matrix-starter">
      <img alt="OpenSSF Scorecard" src="https://api.securityscorecards.dev/projects/github.com/CoderDeltaLAN/ci-matrix-starter/badge" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/supply-chain.yml">
      <img alt="Supply chain" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/supply-chain.yml/badge.svg?branch=main&label=Supply%20chain" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/dependabot-automerge-badge.yml">
      <img alt="Dependabot auto-merge" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/dependabot-automerge-badge.yml/badge.svg?branch=main&label=Dependabot%20auto-merge" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/ghcr-publish-badge.yml">
      <img alt="Publish container to GHCR" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/ghcr-publish-badge.yml/badge.svg?branch=main&label=Publish%20container%20to%20GHCR" />
    </a>
  </p>

  <div><sub><b>**Releases &amp; packaging**</b></sub></div>
  <p>
    <a href="https://pypi.org/project/ci-matrix-starter/">
      <img alt="PyPI" src="https://img.shields.io/pypi/v/ci-matrix-starter?logo=pypi&label=PyPI" />
    </a>
    <a href="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/release-sbom-badge.yml">
      <img alt="release-sbom" src="https://github.com/CoderDeltaLAN/ci-matrix-starter/actions/workflows/release-sbom-badge.yml/badge.svg?branch=main&label=release-sbom" />
    </a>
    <img alt="PyPI pyversions" src="https://img.shields.io/pypi/pyversions/ci-matrix-starter?logo=python&label=PyPI%20pyversions" />
    <img alt="Wheel" src="https://img.shields.io/pypi/wheel/ci-matrix-starter?label=Wheel" />
  </p>

</div>
<!-- BADGES:FOOT:END -->

---

## **Repo layout**

```text
.
├── .github/workflows/
│   ├── build.yml                     # aggregator (example)
│   ├── codeql.yml                    # CodeQL analysis
│   ├── supply-chain.yml              # SBOM + weekly gates
│   ├── release-sbom.yml              # release SBOM publish
│   ├── ghcr-publish.yml              # container to GHCR (example)
│   ├── release-drafter.yml           # release notes draft
│   ├── auto-assign.yml               # auto-assign reviewers
│   ├── labeler.yml                   # PR labeler
│   ├── dependabot-automerge.yml      # auto-merge Dependabot
│   ├── ts-ci.yml                     # reusable TypeScript/Node CI
│   ├── py-ci.yml                     # reusable Python CI
│   └── py-ci-badge.yml               # wrapper for README badge
├── docs/
│   └── screens/
│       └── local-sanity.png          # terminal screenshot (example)
├── src/
│   ├── index.ts                      # minimal TS example
│   └── ci_matrix_starter/            # minimal Py package
├── tests/                            # Python tests (example)
├── package.json                      # Node scripts
├── pyproject.toml                    # Python tooling
└── README.md
```

---

## 🖥️ **Operating System Compatibility** ✅

```text
| OS               | Status |
|------------------|:------:|
| Linux            |   ✅   |
| macOS            |   ✅   |
| Windows (WSL2)   |   ✅   |
| FreeBSD          |   ✅   |
| Android (Termux) |   ✅   |
| Containers (CI)  |   ✅   |
```

---

## 🚀 **Quick Start (consumers)**

### **Use the reusable workflows in _your_ repo**

Create `.github/workflows/ci.yml`:

```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]

jobs:
  # Python matrix (3.11/3.12) with strict gates
  py:
    uses: CoderDeltaLAN/ci-matrix-starter/.github/workflows/py-ci.yml@v0.1.7
    with:
      python_versions: '["3.11","3.12"]'
      run_tests: true

  # TypeScript / Node 20
  ts:
    uses: CoderDeltaLAN/ci-matrix-starter/.github/workflows/ts-ci.yml@v0.1.7
```

> The **aggregator** in this repo (`build.yml`) shows how to orchestrate multiple reusable jobs.

### **Local mirror (same gates as CI)**

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

---

## 📦 **What the workflows expect**

**TypeScript**

- `package.json` with `test` script.
- `tsconfig.json` (scope sources, e.g., `src/**/*.ts`).
- `eslint.config.mjs` (flat) and **Prettier 3**.
- Node **20.x**.

**Python**

- `pyproject.toml` with dev tools (**ruff**, **black**, **pytest**, **mypy**, **poetry**).
- Tests under `tests/`; coverage threshold via `cov-min`.
  Matrix **3.11/3.12** (customizable with `python_versions`).

**Optional SBOM & signing**

- SBOMs (CycloneDX) available. If `COSIGN_KEY` & `COSIGN_PASSWORD` are present, images/artifacts can be signed (safe-by-default: skipped when absent).

---

## ⛳ **Required checks (CI gating)**

**Suggested branch-protection contexts:**

- `CI / build` (aggregator success)
- `CodeQL Analyze / codeql`

**Enable linear history, dismiss stale reviews on new pushes, and auto-merge when green.**

---

## 🧪 **Local Developer Workflow (mirrors CI)**

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

<!-- SCREENSHOT:BEGIN -->

### 👨‍💻 **Local sanity (screenshot)**

<p align="center">
  <img src="docs/screens/local-sanity.png"
       alt="Local sanity (pre-commit, linters and smoke tests passing)"
       width="100%" />
</p>
<!-- SCREENSHOT:END -->

---

## 🔧 **CI (GitHub Actions)**

- Reusable jobs for **Python** and **TypeScript**; call them via `uses:` with a tag (e.g., `@v0.1.7`).
- Built-in **CodeQL** example.
- Strict, fast feedback suitable for PR auto-merge when green.

**Python snippet**

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

**TypeScript snippet**

```yaml
- run: npx prettier --check .
- run: npx eslint . --max-warnings=0
- run: npx tsc --noEmit
- run: npm test --silent || echo "no tests"
```

---

## 🗺 **When to Use This Project**

- You need **ready-to-use CI** for **Python + TypeScript** with clean defaults.
- You want **reusable workflows** referenced by tag.
- You value **security** (CodeQL), **SBOMs**, and **strict gates** to keep `main` always green.

---

## 🧩 **Customization**

- Pin a release tag, e.g., `@v0.1.7`.
- Adjust Python matrix: `with.python_versions`.
- Toggle tests in the wrapper: `with.run_tests` (true/false).
- Provide secrets to enable optional **cosign** signing.
- Extend jobs by adding steps after `uses:`.

---

## 🔒 **Security**

- Code scanning via **CodeQL**.
- Recommend enabling: **required conversations resolved**, **dismiss stale reviews**, **signed commits**, and **squash merges**.
- Avoid uploading sensitive artifacts to public PRs.

---

## 🙌 **Contributing**

- Small, atomic PRs using **Conventional Commits**.
- Keep local & CI gates green before review.
- Use auto-merge once checks pass.

---

## 💚 **Donations & Sponsorship**

**Support open-source: your donations keep projects clean, secure, and evolving for the global community.**

<p align="left">
  <a href="https://www.paypal.com/donate/?hosted_button_id=YVENCBNCZWVPW">
    <img alt="Donate with PayPal" src="https://img.shields.io/badge/Donate-PayPal-0070ba?logo=paypal&logoColor=white" />
  </a>
</p>

---

## 🔎 **SEO Keywords**

reusable github actions workflows, python typescript ci starter, node 20 eslint 9 prettier 3, ruff black mypy pytest, cyclonedx sbom cosign signing, codeql security analysis, branch protection auto merge, always green ci, monorepo friendly ci, strict local gates mirror

---

## 👤 **Author**

**CoderDeltaLAN (Yosvel)**
GitHub: https://github.com/CoderDeltaLAN

---

## 📄 **License**

Released under the **MIT License**. See [LICENSE](LICENSE).
