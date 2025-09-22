FROM busybox:stable-glibc@sha256:4a35a7836fe08f340a42e25c4ac5eef4439585bbbb817b7bd28b2cd87c742642
LABEL org.opencontainers.image.title="ci-matrix-starter"
LABEL org.opencontainers.image.description="Reusable GitHub Actions CI for Python/TypeScript with SBOM & optional signing"
LABEL org.opencontainers.image.source="https://github.com/CoderDeltaLAN/ci-matrix-starter"
CMD ["sh","-c","echo ci-matrix-starter container && tail -f /dev/null"]
