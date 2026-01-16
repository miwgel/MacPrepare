#!/bin/bash
# modules/development/cursor.sh - Instalar Cursor

install_cursor() {
    echo "  Instalando Cursor..."

    if app_installed "Cursor"; then
        echo "  Cursor ya esta instalado"
        return 0
    fi

    brew install --cask cursor

    echo "  Cursor instalado"

    return 0
}

install_cursor
