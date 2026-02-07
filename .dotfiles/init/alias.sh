#!/usr/bin/env zsh
# Custom alias configuration for development workflow
# Organized by category for easy navigation and maintenance

# ============================================================================
# SECTION 1: File System Navigation & Display
# ============================================================================

# Enhanced list command with color support
alias display='ls --color=auto'
alias display_all='ls -lAh --color=auto'
alias display_tree='ls -R'
alias list_long='ls -lh --color=auto'

# Quick directory traversal shortcuts
alias up='cd ..'
alias up2='cd ../..'
alias up3='cd ../../..'
alias up4='cd ../../../..'

# Common directory shortcuts
alias home_dir='cd ~'
alias work_dir='cd ~/projects'
alias get_dir='cd ~/Downloads'

# Colorful grep output
alias search='grep --color=auto'
alias search_ignore='grep -i --color=auto'

# ============================================================================
# SECTION 2: Safety Features for File Operations
# ============================================================================

# Interactive mode for destructive operations
alias delete='rm -i'
alias copy='cp -i'
alias move='mv -i'
# Note: force_delete removed to maintain safety guarantees. Use /bin/rm -rf when needed.

# ============================================================================
# SECTION 3: System Information & Monitoring
# ============================================================================

# Disk and memory information
alias disk_free='df -h'
alias disk_usage='du -h --max-depth=1'
alias memory_info='free -h'

# Network information
alias show_ports='netstat -tulanp'
alias external_ip='curl -s ifconfig.me'
alias internal_ip='hostname -I | cut -d" " -f1'

# ============================================================================
# SECTION 4: Git Command Shortcuts
# ============================================================================

# Status and information commands
alias g='git'
alias gs='git status'
alias gss='git status -s'
alias gl='git log --oneline -10'
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glog='git log --oneline --graph --decorate --all'

# Diff commands
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'

# Branch management
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout main || git checkout master'
alias gcd='git checkout develop'

# Add and commit operations
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcmsg='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'

# Push and pull operations
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gf='git fetch'
alias gfa='git fetch --all'

# Stash operations
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'

# Reset and clean operations
alias grh='git reset HEAD'
alias grhh='git reset --hard HEAD'
alias gclean='git clean -fd'
alias gundo='git reset HEAD~1'

# Miscellaneous git commands
alias gm='git merge'
alias gr='git rebase'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gcl='git clone'
alias gshow='git show'
alias gwip='git add . && git commit -m "WIP: work in progress"'

# ============================================================================
# SECTION 5: Node.js, NPM, and Yarn Commands
# ============================================================================

# NPM shortcuts
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nu='npm uninstall'
alias nup='npm update'
alias nri='npm run install'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias nrtw='npm run test:watch'
alias nrl='npm run lint'
alias nlg='npm list -g --depth=0'

# Yarn shortcuts
alias y='yarn'
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yr='yarn remove'
alias yup='yarn upgrade'
alias yui='yarn upgrade-interactive'
alias ycc='yarn cache clean'
alias ys='yarn start'
alias yd='yarn dev'
alias yb='yarn build'
alias yt='yarn test'
alias ytw='yarn test:watch'
alias yl='yarn lint'
alias yri='yarn run install'

# FNM specific commands (not nvm)
alias node_list='fnm list'
alias node_use='fnm use'
alias node_install='fnm install'
alias node_default='fnm default'
alias node_current='fnm current'

# ============================================================================
# SECTION 6: Docker and Container Management
# ============================================================================

# Docker basic commands
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias dlog='docker logs'
alias dlogf='docker logs -f'
alias dexec='docker exec -it'
alias dinspect='docker inspect'
alias dprune='docker system prune -f'
alias dstats='docker stats'

# Docker Compose commands
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dcps='docker-compose ps'
alias dcr='docker-compose restart'
alias dce='docker-compose exec'
alias dcstop='docker-compose stop'
alias dcstart='docker-compose start'
alias dcpull='docker-compose pull'

# Docker cleanup commands
alias dclean='docker system prune -f'
alias dcleanall='docker system prune -af --volumes'
alias drmall='docker rm -f $(docker ps -aq) 2>/dev/null || echo "No containers to remove"'
alias drmiall='docker rmi -f $(docker images -q) 2>/dev/null || echo "No images to remove"'

# ============================================================================
# SECTION 7: Development Environment Shortcuts
# ============================================================================

# VSCode shortcuts
alias c='code'
alias c.='code .'

# Configuration file quick edits
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias zshreload='source ~/.zshrc'
alias aliases='${EDITOR:-vim} ~/.dotfiles/init/alias.sh'

# Process management
alias pgrep_custom='ps aux | grep -v grep | grep -i -e VSZ'
alias kill9='kill -9'
alias ports_used='lsof -i -P -n | grep LISTEN'

# File size analysis
alias biggest='du -sh * | sort -rh | head -10'
alias diskspace='df -h | grep -E "^/dev/"'

# ============================================================================
# SECTION 8: WSL Windows Integration
# ============================================================================

# Detect WSL environment and add Windows integration
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    alias files='explorer.exe'
    alias open='explorer.exe'
    alias clip='clip.exe'
fi

# ============================================================================
# SECTION 9: Utility Functions
# ============================================================================

# Create directory and navigate into it
mkcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkcd <directory_name>"
        return 1
    fi
    mkdir -p "$1" && cd "$1"
}

# Universal archive extraction
extract() {
    if [[ -z "$1" ]]; then
        echo "Usage: extract <archive_file>"
        return 1
    fi
    
    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' not found"
        return 1
    fi
    
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.tar.xz) tar xJf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.rar) unrar x "$1" ;;
        *) echo "Error: '$1' cannot be extracted via extract()" && return 1 ;;
    esac
}

# Git: create and checkout new branch
gcnew() {
    if [[ -z "$1" ]]; then
        echo "Usage: gcnew <branch_name>"
        return 1
    fi
    git checkout -b "$1"
}

# Git: add all and commit with message
gac() {
    if [[ -z "$1" ]]; then
        echo "Usage: gac <commit_message>"
        return 1
    fi
    git add . && git commit -m "$1"
}

# Git: add, commit, and push
gacp() {
    if [[ -z "$1" ]]; then
        echo "Usage: gacp <commit_message>"
        return 1
    fi
    git add . && git commit -m "$1" && git push
}

# Docker: remove containers by name pattern
drm-name() {
    if [[ -z "$1" ]]; then
        echo "Usage: drm-name <container_name_pattern>"
        return 1
    fi
    docker ps -aq --filter "name=$1" | xargs -r docker rm -f
}

# Kill process running on specific port
port-kill() {
    if [[ -z "$1" ]]; then
        echo "Usage: port-kill <port_number>"
        return 1
    fi
    # Ensure the port is a numeric value to prevent command injection
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: port must be a numeric value"
        return 1
    fi
    local process_id
    process_id=$(lsof -t -i :"$1")
    if [[ -n "$process_id" ]]; then
        kill -9 -- $process_id
        echo "Killed process on port $1"
    else
        echo "No process found on port $1"
    fi
}

# Start simple HTTP server
serve() {
    local port="${1:-8000}"
    echo "Starting HTTP server on port $port..."
    python3 -m http.server "$port"
}

# Clean up merged git branches
git-clean-branches() {
    echo "Cleaning up merged branches..."
    # List merged branches, excluding current branch (*) and protected branches
    # Use grep -E for portable extended regex instead of GNU-specific \| in basic regex
    local branches
    branches=(${(f)"$(git branch --merged | grep -Ev '^\*|^[[:space:]]*(main|master|develop)$')"})
    if (( ${#branches} > 0 )); then
        git branch -d "${branches[@]}"
    else
        echo "No merged branches to delete."
    fi
    echo "Cleanup complete!"
}

# ============================================================================
# SECTION 10: Dotfiles Management Functions (Linux)
# ============================================================================

# Update dotfiles from GitHub with rebase
dot-update() {
    # Get the repository root (parent of .dotfiles directory)
    local dotfiles_repo
    if [[ -n "$DOTFILES_HOME" ]]; then
        dotfiles_repo="$(dirname "$DOTFILES_HOME")"
    else
        dotfiles_repo="$HOME"
    fi
    
    echo "Updating dotfiles from GitHub..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Pull with rebase
    git pull --rebase
    local exit_code=$?
    
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles updated successfully!"
    else
        echo "✗ Failed to update dotfiles"
        return $exit_code
    fi
}

# Commit all dotfiles changes with optional flags
dot-commit() {
    # Get the repository root (parent of .dotfiles directory)
    local dotfiles_repo
    if [[ -n "$DOTFILES_HOME" ]]; then
        dotfiles_repo="$(dirname "$DOTFILES_HOME")"
    else
        dotfiles_repo="$HOME"
    fi
    
    # Validate that we have at least some arguments
    if [[ $# -eq 0 ]]; then
        echo "Usage: dot-commit <git commit flags>"
        echo "Example: dot-commit -m 'Update aliases'"
        echo "Example: dot-commit --amend --no-edit"
        return 1
    fi
    
    echo "Committing dotfiles changes..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Add all changes
    git add .
    
    # Commit with all provided flags/arguments
    # Using "$@" preserves all arguments exactly as passed
    git commit "$@"
    local exit_code=$?
    
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles committed successfully!"
    else
        echo "✗ Failed to commit dotfiles"
        return $exit_code
    fi
}

# Push dotfiles changes to GitHub
dot-push() {
    # Get the repository root (parent of .dotfiles directory)
    local dotfiles_repo
    if [[ -n "$DOTFILES_HOME" ]]; then
        dotfiles_repo="$(dirname "$DOTFILES_HOME")"
    else
        dotfiles_repo="$HOME"
    fi
    
    echo "Pushing dotfiles to GitHub..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Push to origin
    git push
    local exit_code=$?
    
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles pushed successfully!"
    else
        echo "✗ Failed to push dotfiles"
        return $exit_code
    fi
}
