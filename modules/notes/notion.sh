#!/bin/bash
# modules/notes/notion.sh - Instalar Notion

install_notion() {
    echo "  Instalando Notion..."

    if app_installed "Notion"; then
        echo "  Notion ya esta instalado"
        return 0
    fi

    brew install --cask notion

    echo "  Notion instalado"

    return 0
}

install_notion
