##
# Node version manager

NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
    export NVM_DIR=$NVM_DIR
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
