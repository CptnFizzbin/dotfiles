##
# Python Environment manager

PYENV_ROOT="$HOME/.pyenv"
if [ -s $PYENV_ROOT ]; then
    export PYENV_ROOT=$PYENV_ROOT
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi