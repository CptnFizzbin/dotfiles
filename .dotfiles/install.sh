#!/usr/bin/env bash
# Bootstrap dotfiles on a new machine.
# Safe to re-run — existing files are backed up, not overwritten.
set -euo pipefail

REPO="git@github.com:CptnFizzbin/dotfiles.git"
DOTFILES_HOME="$HOME/.dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

info()    { echo "  --> $*"; }
success() { echo "  ✓  $*"; }
warn()    { echo "  !  $*"; }

backup_if_exists() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
        warn "Backed up existing $(basename "$target") to $BACKUP_DIR/"
    fi
}

echo ""
echo "Dotfiles installer"
echo "=================="
echo ""

# ── 1. Clone and copy files ────────────────────────────────────────────────
if [[ -d "$DOTFILES_HOME" ]]; then
    info ".dotfiles already present — skipping clone"
else
    info "Cloning dotfiles..."
    TMP=$(mktemp -d)
    git clone "$REPO" "$TMP/dotfiles"

    ROOT_FILES=(.bashrc .zshrc .zprofile .gitconfig .gitattributes .gitignore .bash_logout)
    for f in "${ROOT_FILES[@]}"; do
        if [[ -f "$TMP/dotfiles/$f" ]]; then
            backup_if_exists "$HOME/$f"
            cp "$TMP/dotfiles/$f" "$HOME/$f"
        fi
    done

    cp -r "$TMP/dotfiles/.dotfiles" "$DOTFILES_HOME"
    rm -rf "$TMP"
    success "Dotfiles copied to home directory"
fi

# ── 2. Oh My Zsh ──────────────────────────────────────────────────────────
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    info "Oh My Zsh already installed"
else
    info "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    success "Oh My Zsh installed"
fi

# ── 3. Zsh plugins ────────────────────────────────────────────────────────
install_zsh_plugin() {
    local name="$1"
    local url="$2"
    local dest="$ZSH_CUSTOM/plugins/$name"
    if [[ -d "$dest" ]]; then
        info "$name already installed"
    else
        info "Installing $name..."
        git clone --depth=1 "$url" "$dest"
        success "$name installed"
    fi
}

install_zsh_plugin zsh-autosuggestions    https://github.com/zsh-users/zsh-autosuggestions
install_zsh_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting

# ── 4. FNM ────────────────────────────────────────────────────────────────
if command -v fnm &>/dev/null; then
    info "fnm already installed"
else
    info "Installing fnm (Node.js version manager)..."
    curl -fsSL https://fnm.vercel.app/install | bash
    success "fnm installed"
fi

# ── 5. Default shell ──────────────────────────────────────────────────────
if command -v zsh &>/dev/null; then
    ZSH_PATH="$(command -v zsh)"
    if [[ "$SHELL" != "$ZSH_PATH" ]]; then
        info "Setting zsh as default shell..."
        chsh -s "$ZSH_PATH"
        success "Default shell set to zsh"
    else
        info "zsh is already the default shell"
    fi
else
    warn "zsh not found — install it and re-run to set as default"
fi

# ── Done ──────────────────────────────────────────────────────────────────
echo ""
echo "Done! Start a new shell or run: source ~/.zshrc"
[[ -d "$BACKUP_DIR" ]] && echo "Previous files backed up to: $BACKUP_DIR"
echo ""
