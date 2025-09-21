#!/usr/bin/env zsh
# Limpieza segura de runs rojos, artefactos expirados y deployments fallidos.
# No usa set/setopt ni modifica tu sesión interactiva.

DRYRUN=${DRYRUN:-0}        # DRYRUN=1 para simular sin borrar
ENV_NAME=${ENV_NAME:-pypi} # environment a revisar para deployments

# Requisitos
command -v gh >/dev/null || { print -u2 "Falta GitHub CLI (gh)"; exit 1; }
command -v jq >/dev/null || { print -u2 "Falta jq"; exit 1; }

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
[[ -z "$REPO" ]] && { print -u2 "gh no autenticado en este repo"; exit 1; }

print "▶ Repo: $REPO"
print "▶ DRYRUN=$DRYRUN  ENV_NAME=$ENV_NAME"

# Helper de página (no rompe si falla)
_page() { gh api -H "Accept: application/vnd.github+json" "$1" 2>/dev/null || echo '{}'; }

# ----- 1) RUNS ROJOS -----
integer page=1 seen=0 del_runs=0
print "▶ Analizando workflow runs (failure,cancelled,timed_out,startup_failure,action_required)…"
while true; do
  json=$(_page "/repos/$REPO/actions/runs?per_page=100&page=$page&status=completed")
  count=$(print -r -- "$json" | jq '.workflow_runs|length')
  [[ "$count" = "0" ]] && break

  ids=($(print -r -- "$json" | jq -r '
    .workflow_runs[] | select(
      .conclusion=="failure" or
      .conclusion=="cancelled" or
      .conclusion=="timed_out" or
      .conclusion=="startup_failure" or
      .conclusion=="action_required"
    ) | .id'))
  (( seen += ${#ids[@]} ))
  for id in "${ids[@]}"; do
    if (( DRYRUN )); then
      print "  DRY: delete run $id"
    else
      gh api -X DELETE "/repos/$REPO/actions/runs/$id" >/dev/null 2>&1 && ((del_runs++))
      sleep 0.15
    fi
  done
  ((page++))
done
print "▶ Runs rojos detectados: $seen | eliminados: $del_runs"

# ----- 2) ARTEFACTOS EXPIRADOS -----
integer page=1 del_art=0
print "▶ Limpiando artefactos expirados…"
while true; do
  ajson=$(_page "/repos/$REPO/actions/artifacts?per_page=100&page=$page")
  count=$(print -r -- "$ajson" | jq '.artifacts|length')
  [[ "$count" = "0" ]] && break

  aids=($(print -r -- "$ajson" | jq -r '.artifacts[] | select(.expired==true) | .id'))
  for aid in "${aids[@]}"; do
    if (( DRYRUN )); then
      print "  DRY: delete artifact $aid"
    else
      gh api -X DELETE "/repos/$REPO/actions/artifacts/$aid" >/dev/null 2>&1 && ((del_art++))
      sleep 0.1
    fi
  done
  ((page++))
done
print "▶ Artefactos expirados eliminados: $del_art"

# ----- 3) DEPLOYMENTS (ENV) -----
integer page=1 seen_dep=0 del_dep=0
print "▶ Analizando deployments en '$ENV_NAME'…"
while true; do
  dj=$(_page "/repos/$REPO/deployments?environment=$ENV_NAME&per_page=100&page=$page")
  cnt=$(print -r -- "$dj" | jq 'length')
  [[ "$cnt" = "0" ]] && break

  dids=($(print -r -- "$dj" | jq -r '.[].id'))
  for did in "${dids[@]}"; do
    ((seen_dep++))
    sj=$(_page "/repos/$REPO/deployments/$did/statuses?per_page=1")
    state=$(print -r -- "$sj" | jq -r '.[0].state // "inactive"')
    if [[ "$state" == "failure" || "$state" == "error" ]]; then
      if (( DRYRUN )); then
        print "  DRY: inactivate+delete deployment $did ($state)"
      else
        gh api -X POST "/repos/$REPO/deployments/$did/statuses" \
           -f state=inactive -f description="cleanup" >/dev/null 2>&1
        gh api -X DELETE "/repos/$REPO/deployments/$did" >/dev/null 2>&1 && ((del_dep++))
        sleep 0.15
      fi
    fi
  done
  ((page++))
done
print "▶ Deployments analizados: $seen_dep | eliminados (rojos): $del_dep"
print "✅ Limpieza completa."
