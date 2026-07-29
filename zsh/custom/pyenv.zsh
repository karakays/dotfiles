export PYENV_ROOT="$HOME/.pyenv"

# Keep pyenv shims on PATH so `python`, `pip`, etc. can resolve through pyenv
# when versions are installed, without running the slow `pyenv init` scripts.
if [[ -d "$PYENV_ROOT/bin" ]]; then
  path=(${path:#"$PYENV_ROOT/bin"})
  path=("$PYENV_ROOT/bin" $path)
fi

if [[ -d "$PYENV_ROOT/shims" ]]; then
  path=(${path:#"$PYENV_ROOT/shims"})
  path=("$PYENV_ROOT/shims" $path)
fi

# Load pyenv's shell integration only when the `pyenv` command is used.
# This defers completions, `pyenv shell`, and `pyenv rehash` out of shell startup.
if command -v pyenv >/dev/null 2>&1; then
  pyenv() {
    unset -f pyenv
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
fi
