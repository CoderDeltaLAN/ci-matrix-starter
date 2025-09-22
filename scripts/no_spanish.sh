#!/usr/bin/env bash
# Warn if Spanish text sneaks into the codebase (default warn-only).
set -u
STRICT="${STRICT:-0}"
EXCLUDES=(
  --exclude-dir .git --exclude-dir node_modules --exclude-dir _ci_local
)
PATTERN='[áéíóúÁÉÍÓÚñÑ¿¡]|<(es|span)>' # diacríticos y tags HTML
rg -n -S "${EXCLUDES[@]}" -e "$PATTERN" . || EXIT=$?
if [ "${EXIT:-0}" -ne 0 ]; then exit 0; fi
echo "Spanish-like text detected above."
[ "$STRICT" = "1" ] && exit 1 || exit 0
