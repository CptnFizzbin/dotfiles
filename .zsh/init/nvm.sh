##
# Node version manager

NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR=$NVM_DIR
    \. "$NVM_DIR/nvm.sh"
    \. "$NVM_DIR/bash_completion"
fi
