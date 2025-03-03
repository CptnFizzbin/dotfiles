##
# Fast and simple Node.js version manager
# https://github.com/Schniz/fnm

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh --corepack-enabled --resolve-engines)"
fi