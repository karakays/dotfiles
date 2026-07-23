#!/bin/zsh

set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-$HOME/.local/bin/herdr}"
snapshot="$("$herdr_bin" api snapshot)"

workspace_rows="$(jq -r '
  .result.snapshot as $snapshot
  | $snapshot.workspaces[] as $workspace
  | ([$snapshot.panes[]
      | select(.workspace_id == $workspace.workspace_id)
      | .cwd][0] // "") as $cwd
  | [
      "space",
      $workspace.workspace_id,
      $workspace.label,
      $cwd,
      ("● " + $workspace.label + "  ·  " + $cwd)
    ]
  | @tsv
' <<< "$snapshot")"

open_paths="$(jq -r '
  .result.snapshot as $snapshot
  | $snapshot.workspaces[] as $workspace
  | [$snapshot.panes[]
     | select(.workspace_id == $workspace.workspace_id)
     | .cwd][0] // empty
' <<< "$snapshot")"

zoxide_rows="$(
  zoxide query -l | while IFS= read -r directory; do
    if ! grep -Fqx -- "$directory" <<< "$open_paths"; then
      printf 'zoxide\t-\t%s\t%s\t+ %s  ·  %s\n' \
        "${directory:t}" "$directory" "${directory:t}" "$directory"
    fi
  done
)"

selection="$(
  printf '%s\n%s\n' "$workspace_rows" "$zoxide_rows" |
    sed '/^$/d' |
    fzf \
      --style=minimal \
      --layout=reverse \
      --delimiter=$'\t' \
      --with-nth=5 \
      --border=none \
      --margin=0 \
      --no-separator \
      --no-scrollbar \
      --gutter=' ' \
      --pointer='›' \
      --marker='✓' \
      --prompt='Space › ' \
      --info='inline-right' \
      --header='● open  + zoxide  ·  Ctrl-j/k move  ·  Enter select' \
      --header-first \
      --color='bg:#fbf1c7,bg+:#ebdbb2,fg:#504945,fg+:#282828,hl:#b57614,hl+:#d65d0e,prompt:#076678,pointer:#9d0006,marker:#79740e,spinner:#427b58,header:#7c6f64,info:#928374,gutter:#fbf1c7' \
      --bind='ctrl-j:down,ctrl-k:up'
)" || exit 0

IFS=$'\t' read -r source workspace_id label directory _display <<< "$selection"

if [[ "$source" == "space" ]]; then
  "$herdr_bin" workspace focus "$workspace_id" >/dev/null
else
  "$herdr_bin" workspace create \
    --cwd "$directory" \
    --label "$label" \
    --focus >/dev/null
fi
