##
# Bun is a fast JavaScript all-in-one toolkit
# https://bun.sh/

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$BUN_INSTALL/.bun/_bun" ] && source "$BUN_INSTALL/.bun/_bun"