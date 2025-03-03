##
# Bun is a fast JavaScript all-in-one toolkit
# https://bun.sh/

BUN_INSTALL="$HOME/.bun"
if [ -d "$BUN_INSTALL" ]; then
    export BUN_INSTALL=$BUN_INSTALL
    export PATH="$BUN_INSTALL/bin:$PATH"

    # bun completions
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi