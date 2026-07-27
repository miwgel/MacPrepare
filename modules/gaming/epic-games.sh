#!/bin/bash
# modules/gaming/epic-games.sh - Install Epic Games Launcher

install_epic_games() {
    echo "  Installing Epic Games Launcher..."

    if app_installed "Epic Games Launcher"; then
        echo "  Epic Games Launcher is already installed"
        return 0
    fi

    brew install --cask epic-games || return 1
    echo "  Epic Games Launcher installed"

    return 0
}

install_epic_games
