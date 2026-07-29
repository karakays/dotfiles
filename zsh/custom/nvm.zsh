export NVM_DIR="$HOME/.config/nvm"

# Keep the default Node version's global binaries available immediately
# (`node`, `npm`, `pnpm`, `codex`, `claude`) without sourcing slow `nvm.sh`.
if [[ -r "$NVM_DIR/alias/default" ]]; then
  nvm_default_version="$(<"$NVM_DIR/alias/default")"
  [[ "$nvm_default_version" == v* ]] || nvm_default_version="v$nvm_default_version"

  if [[ -d "$NVM_DIR/versions/node/$nvm_default_version/bin" ]]; then
    path=("$NVM_DIR/versions/node/$nvm_default_version/bin" ${path:#"$NVM_DIR/versions/node/$nvm_default_version/bin"})
  fi

  unset nvm_default_version
fi

# Load the real NVM shell integration only when the `nvm` command is used.
# This avoids paying NVM's startup cost in every new shell.
nvm() {
  unset -f nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}
