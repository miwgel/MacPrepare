#!/bin/bash
# modules/gaming/epic-games.sh - Instalar Epic Games Launcher

install_epic_games() {
    echo "  Instalando Epic Games Launcher..."

    if app_installed "Epic Games Launcher"; then
        echo "  Epic Games Launcher ya esta instalado"
        return 0
    fi

    brew install --cask epic-games

    echo "  Epic Games Launcher instalado"

    return 0
}

install_epic_games
