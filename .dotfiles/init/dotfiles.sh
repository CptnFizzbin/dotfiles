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

# Update dotfiles from GitHub with rebase
dot-update() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
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
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    echo "Committing dotfiles changes..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Add all changes and commit only if add succeeds
    # Using "$@" preserves all arguments exactly as passed
    git add . && git commit "$@"
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
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    echo "Pushing dotfiles to GitHub..."
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Push to origin explicitly
    git push origin
    local exit_code=$?
    
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles pushed successfully!"
    else
        echo "✗ Failed to push dotfiles"
        return $exit_code
    fi
}
