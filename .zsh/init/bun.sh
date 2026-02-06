##
# Bun is a fast JavaScript all-in-one toolkit
# https://bun.sh/

BUN_ROOT="$HOME/.bun"
if [ -s "$BUN_ROOT/_bun" ]; then
    export BUN_INSTALL=$BUN_ROOT
    export PATH="$BUN_ROOT/bin:$PATH"
    source "$BUN_ROOT/_bun"
fi