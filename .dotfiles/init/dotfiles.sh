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
    
    # Handle case where both .git and .git.dotfiles exist
    if [[ -d "$dotfiles_repo/.git" && -d "$dotfiles_repo/.git.dotfiles" ]]; then
        echo "Error: Both .git and .git.dotfiles exist. Please resolve manually." >&2
        return 1
    fi
    
    # Only move if .git.dotfiles exists (handles manual renaming)
    if [[ -d "$dotfiles_repo/.git.dotfiles" ]]; then
        if ! mv "$dotfiles_repo/.git.dotfiles" "$dotfiles_repo/.git" 2>/dev/null; then
            echo "Error: Failed to enable git directory (rename .git.dotfiles to .git)" >&2
            return 1
        fi
    fi
    
    return 0
}

# Helper function to disable git for dotfiles (rename .git to .git.dotfiles)
__dotfiles_git_disable() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    # Handle case where both .git and .git.dotfiles exist
    if [[ -d "$dotfiles_repo/.git" && -d "$dotfiles_repo/.git.dotfiles" ]]; then
        echo "Error: Both .git and .git.dotfiles exist. Please resolve manually." >&2
        return 1
    fi
    
    # Only move if .git exists
    if [[ -d "$dotfiles_repo/.git" ]]; then
        if ! mv "$dotfiles_repo/.git" "$dotfiles_repo/.git.dotfiles" 2>/dev/null; then
            echo "Error: Failed to disable git directory (rename .git to .git.dotfiles)" >&2
            return 1
        fi
    fi
    
    return 0
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
    
    # Set up trap to ensure cleanup on exit/interrupt
    trap '__dotfiles_git_disable; popd > /dev/null 2>&1' EXIT INT TERM
    
    # Enable git for dotfiles operations
    if ! __dotfiles_git_enable; then
        trap - EXIT INT TERM
        popd > /dev/null
        return 1
    fi
    
    # Pull with rebase
    git pull --rebase
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
    # Clear trap and popd
    trap - EXIT INT TERM
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles updated successfully!"
    else
        echo "✗ Failed to update dotfiles"
        return $exit_code
    fi
}

dot-status() {
    local dotfiles_repo="$(__dotfiles_repo_root)"
    
    # Change to dotfiles repository root
    pushd "$dotfiles_repo" > /dev/null || {
        echo "Error: Could not change to dotfiles repository: $dotfiles_repo"
        return 1
    }
    
    # Set up trap to ensure cleanup on exit/interrupt
    trap '__dotfiles_git_disable; popd > /dev/null 2>&1' EXIT INT TERM
    
    # Enable git for dotfiles operations
    if ! __dotfiles_git_enable; then
        trap - EXIT INT TERM
        popd > /dev/null
        return 1
    fi
    
    # Add all changes and commit only if add succeeds
    # Using "$@" preserves all arguments exactly as passed
    git status "$@"
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
    # Clear trap and popd
    trap - EXIT INT TERM
    popd > /dev/null
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
    
    # Set up trap to ensure cleanup on exit/interrupt
    trap '__dotfiles_git_disable; popd > /dev/null 2>&1' EXIT INT TERM
    
    # Enable git for dotfiles operations
    if ! __dotfiles_git_enable; then
        trap - EXIT INT TERM
        popd > /dev/null
        return 1
    fi
    
    # Add all changes and commit only if add succeeds
    # Using "$@" preserves all arguments exactly as passed
    git add . && git commit "$@"
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
    # Clear trap and popd
    trap - EXIT INT TERM
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
    
    # Set up trap to ensure cleanup on exit/interrupt
    trap '__dotfiles_git_disable; popd > /dev/null 2>&1' EXIT INT TERM
    
    # Enable git for dotfiles operations
    if ! __dotfiles_git_enable; then
        trap - EXIT INT TERM
        popd > /dev/null
        return 1
    fi
    
    # Push to origin explicitly
    git push origin
    local exit_code=$?
    
    # Disable git for dotfiles
    __dotfiles_git_disable
    
    # Clear trap and popd
    trap - EXIT INT TERM
    popd > /dev/null
    
    if [[ $exit_code -eq 0 ]]; then
        echo "✓ Dotfiles pushed successfully!"
    else
        echo "✗ Failed to push dotfiles"
        return $exit_code
    fi
}
