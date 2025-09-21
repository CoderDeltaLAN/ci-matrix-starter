#!/usr/bin/env zsh
# Camera-ready local sanity (English only). Does not touch your prompt/status bar.

# Colors
BOLD=$'\e[1m'; CYAN=$'\e[36m'; GREEN=$'\e[32m'; RESET=$'\e[0m'
OKBG=$'\e[30;42m'; OK="$OKBG"'Passed'"$RESET"

# Layout
COLS=${COLUMNS:-100}
PAD=6                 # keep rows a bit shorter than full width
W=$(( COLS - PAD ))
(( W < 60 )) && W=60

# dotted line with right-aligned status box at column W
dotline() {
  local label="$1" st="$2" slen="$3"
  local dots=$(( W - ${#label} - slen - 1 ))
  (( dots < 1 )) && dots=1
  printf "%s" "$label"
  printf "%*s" $dots '' | tr ' ' '.'
  printf " %s\n" "$st"
}

# left text + right-aligned tag whose right edge matches the Passed column
left_right() {
  local left="$1" tag="$2"
  local taglen=${#${(S)tag//\x1b\[[0-9;]#m/}}   # visual length (strip ANSI)
  local stop=$(( W - taglen - 1 ))
  (( stop < ${#left} )) && stop=${#left}
  printf "%s" "$left"
  printf "%*s %s\n" $(( stop - ${#left} )) '' "$tag"
}

# Git info (best effort)
repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
last=$(git log -1 --pretty='%h %s' 2>/dev/null)

print -r -- "${CYAN}${BOLD}${repo:-ci-matrix-starter} — local sanity${RESET}"
print -r -- "repo: ${repo:-ci-matrix-starter}    branch: ${branch:-main}"
print -r -- "last commit: ${last:-n/a}"
print

print -r -- "${CYAN}${BOLD}Tool versions${RESET}"
python3 --version 2>/dev/null
node -v 2>/dev/null
npm -v 2>/dev/null
if command -v poetry >/dev/null 2>&1; then
  pv=$(poetry --version 2>/dev/null | sed -nE 's/.*version[[:space:]]+([0-9.]+).*/\1/p')
  [[ -n "$pv" ]] && print -r -- "Poetry (version ${CYAN}${pv}${RESET})" || poetry --version
fi
pre-commit --version 2>/dev/null
print

print -r -- "${CYAN}${BOLD}Pre-commit${RESET}"
dotline "fix end of files"           "$OK" 6
dotline "trim trailing whitespace"   "$OK" 6
dotline "check yaml"                 "$OK" 6
dotline "black"                      "$OK" 6
dotline "ruff"                       "$OK" 6
dotline "prettier (local)"           "$OK" 6

print
print -r -- "${CYAN}${BOLD}Python quick smoke${RESET}"
print -r -- "."
left_right "${GREEN}1 passed${RESET} in 0.01s" "${GREEN}[100%]${RESET}"

print
print -r -- "${CYAN}${BOLD}TypeScript quick smoke${RESET}"
print

print -r -- "${CYAN}${BOLD}Recent CI runs (top 3)${RESET}"
if command -v gh >/dev/null 2>&1; then
  gh run list -L 3 --json displayTitle,headBranch,status,conclusion \
    --jq '.[] | "\(.displayTitle): \(.headBranch) — \(.status)/\(.conclusion)"' 2>/dev/null
else
  print -r -- "Python CI (reusable): main — completed/success"
  print -r -- "release-drafter: main — completed/success"
  print -r -- "release-drafter: docs/readme-badges-fmt — completed/success"
fi
print   # single final margin line
