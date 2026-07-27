#!/bin/bash
# modules/development/git.sh - Install/update Git y GitHub Desktop

install_git() {
    local variant="${1:-git}"

    if [ "$variant" = "desktop" ]; then
        echo "  Installing GitHub Desktop..."

        if app_installed "GitHub Desktop"; then
            echo "  GitHub Desktop is already installed"
            return 0
        fi

        brew install --cask github || return 1
        echo "  GitHub Desktop installed"
    else
        echo "  Updating Git..."

        # Install/actualizar git via Homebrew (mas reciente que el de macOS)
        brew install git || return 1
        echo "  Git updated to: $(git --version)"
    fi

    return 0
}

install_git "$1"
