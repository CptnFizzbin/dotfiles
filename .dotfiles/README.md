# dotfiles

Personal dotfiles for Captain Fizzbin — shell, git, and dev tooling managed as a git repo overlaid directly on `$HOME`.

## How it works

The repo root is `$HOME`. A root `.gitignore` that ignores everything means only explicitly force-added files are tracked. The `.git` directory is renamed to `.git.dotfiles` when not in use so everyday git commands elsewhere in `~` don't accidentally pick up the dotfiles repo — the `dot-*` helpers toggle this automatically.

## Structure

```
~
├── .bashrc              # Bash entry point — sources dotfiles init
├── .zshrc               # Zsh entry point — sets DOTFILES_HOME, calls init.sh
├── .gitconfig           # Git config with SSH commit signing via 1Password
├── .gitattributes       # EOL and binary file rules
└── .dotfiles/
    ├── README.md        # This file
    ├── install.sh       # Bootstrap script for new machines
    ├── init.sh          # Sources all init/*.sh then local/*.sh
    ├── init/            # Modular init scripts loaded by init.sh
    │   ├── alias.sh     # Aliases and utility functions
    │   ├── dotfiles.sh  # dot-* management commands
    │   ├── zsh.sh       # Oh My Zsh config and plugin list
    │   ├── fnm.sh       # Node.js version manager
    │   ├── pyenv.sh     # Python version manager
    │   ├── rbenv.sh     # Ruby version manager
    │   ├── zoxide.sh    # Smart cd replacement
    │   ├── bun.sh       # Bun JavaScript toolkit
    │   ├── vault.sh     # HashiCorp Vault integration
    │   ├── jetbrains.sh # JetBrains IDE tooling
    │   └── mstools.sh   # MS SQL Tools path
    ├── local/           # Machine-specific overrides (gitignored)
    │   └── local.sh.example
    └── zsh_custom/
        └── themes/
            └── cptnfizzbin.zsh-theme
```

## Installation on a new machine

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/CptnFizzbin/dotfiles/main/.dotfiles/install.sh)
```

Or clone manually:

```bash
git clone git@github.com:CptnFizzbin/dotfiles.git /tmp/dotfiles-setup
bash /tmp/dotfiles-setup/.dotfiles/install.sh
```

## dot-* commands

| Command | Description |
|---|---|
| `dot-status` | Show git status of the dotfiles repo |
| `dot-add <file>` | Force-add a file to tracking |
| `dot-commit -m "msg"` | Stage all changes and commit |
| `dot-push` | Push to origin |
| `dot-update` | Pull latest changes with rebase |
| `dot-git <args>` | Run any git command against the dotfiles repo |

## Local machine overrides

Copy `.dotfiles/local/local.sh.example` to `.dotfiles/local/local.sh` and customize. Everything in `.dotfiles/local/` is gitignored and stays on the current machine only — use it for work email, proxy settings, machine-specific paths, or private aliases.

## Shell startup benchmark

```bash
dot-bench
```

Runs five timed `zsh -i -c exit` measurements so you can catch startup regressions when adding new tools.

## Notes

- **SSH signing**: commits are signed via 1Password (`op-ssh-sign.exe`) using an ed25519 key
- **WSL**: git is configured to use Windows OpenSSH (`/mnt/c/WINDOWS/System32/OpenSSH/ssh.exe`) for WSL compatibility
- **`.git` toggle**: the `__dotfiles_git_enable` / `__dotfiles_git_disable` helpers in `dotfiles.sh` rename `.git` ↔ `.git.dotfiles` so the repo is invisible to other tools most of the time
