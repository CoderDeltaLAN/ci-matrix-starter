# ci-matrix-starter

Reusable GitHub Actions workflows for Python and TypeScript:

- Lint/Format/Types/Tests
- SBOM (CycloneDX)
- Optional cosign signing

Jobs are exposed via `workflow_call` so downstream repos can consume them.
