#!/usr/bin/env zsh
# Dotfiles management functions for Linux
# Provides commands to update, commit, and push dotfiles repository changes

# ============================================================================
# Dotfiles Management Functions
# ============================================================================

# Helper function to get dotfiles repository root
__dotfiles_repo_root() {
    if [[ -n "$DOTFILES_HOME" ]]; then
        dirname "$DOTFILES_HOME"
    else
        echo "$HOME"
    fi
}

# Helper function to enable git for dotfiles (rename .git.dotfiles to .git)
__dotfiles_git_enable() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    if [[ -d "$dotfiles_repo/.git.dotfiles" && ! -d "$dotfiles_repo/.git" ]]; then
        mv "$dotfiles_repo/.git.dotfiles" "$dotfiles_repo/.git"
    fi
}

# Helper function to disable git for dotfiles (rename .git to .git.dotfiles)
__dotfiles_git_disable() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    if [[ -d "$dotfiles_repo/.git" && ! -d "$dotfiles_repo/.git.dotfiles" ]]; then
        mv "$dotfiles_repo/.git" "$dotfiles_repo/.git.dotfiles"
    fi
}

# Update dotfiles from GitHub with rebase
dot-update() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    echo "Updating dotfiles from GitHub..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Enable git for dotfiles operations
    __dotfiles_git_enable
    
    # Pull with rebase
    git pull --rebase
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
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
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    echo "Committing dotfiles changes..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Enable git for dotfiles operations
    __dotfiles_git_enable
    
    # Add all changes and commit only if add succeeds
    # Using "$@" preserves all arguments exactly as passed
    git add . && git commit "$@"
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
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
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    echo "Pushing dotfiles to GitHub..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Enable git for dotfiles operations
    __dotfiles_git_enable
    
    # Get current branch name
    local current_branch=$(git branch --show-current)
    
    # Ensure branch is prefixed with 'linux'
    if [[ ! "$current_branch" =~ ^linux ]]; then
        echo "Warning: Branch '$current_branch' does not start with 'linux' prefix"
    fi
    
    # Push to origin explicitly
    git push origin
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles pushed successfully!"
    else
        echo "✗ Failed to push dotfiles"
        return $exit_code
    fi
}
