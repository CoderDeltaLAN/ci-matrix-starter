FROM busybox:stable-glibc
LABEL org.opencontainers.image.title="ci-matrix-starter"
LABEL org.opencontainers.image.description="Reusable GitHub Actions CI for Python/TypeScript with SBOM & optional signing"
LABEL org.opencontainers.image.source="https://github.com/CoderDeltaLAN/ci-matrix-starter"
CMD ["sh","-c","echo ci-matrix-starter container && tail -f /dev/null"]
