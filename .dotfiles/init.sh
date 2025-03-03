export DOTFILES_INIT="$DOTFILES_HOME/init"
export DOTFILES_LOCAL="$DOTFILES_HOME/local"

source "$DOTFILES_INIT/zoxide.sh"
source "$DOTFILES_INIT/zsh.sh"

if [ -s "$DOTFILES_HOME/local.sh" ]; then
    source "$DOTFILES_HOME/local.sh"
else
    echo "[warn] $DOTFILES_HOME/local.sh not found"
fi

source "$DOTFILES_HOME/alias.sh"