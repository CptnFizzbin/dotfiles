##
# Ruby Version Manager

RBENV_ROOT="$HOME/.rbenv"

if [ -s $RBENV_ROOT ]; then
    export RBENV_ROOT=$RBENV_ROOT
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init - zsh)"
fi