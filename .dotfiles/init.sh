export DOTFILES_INIT="$DOTFILES_HOME/init"
export DOTFILES_LOCAL="$DOTFILES_HOME/local"

for filename in "$DOTFILES_INIT"/*.sh; do
  [ -f "$filename" ] || continue  # Skip if no files match
  source "$filename"
done

for filename in "$DOTFILES_LOCAL"/*.sh; do
  [ -f "$filename" ] || continue  # Skip if no files match
  source "$filename"
done

if [ -s "$DOTFILES_HOME/local.sh" ]; then
  source "$DOTFILES_HOME/local.sh"
fi
