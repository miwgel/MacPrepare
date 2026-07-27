#!/bin/bash
# modules/notes/notion.sh - Install Notion

install_notion() {
    echo "  Installing Notion..."

    if app_installed "Notion"; then
        echo "  Notion is already installed"
        return 0
    fi

    brew install --cask notion || return 1
    echo "  Notion installed"

    return 0
}

install_notion
