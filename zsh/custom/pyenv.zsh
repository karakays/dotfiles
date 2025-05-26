export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Set up pyenv in login + interactive shells
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
