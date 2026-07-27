#!/bin/bash
# modules/development/cursor.sh - Install Cursor

install_cursor() {
    echo "  Installing Cursor..."

    if app_installed "Cursor"; then
        echo "  Cursor is already installed"
        return 0
    fi

    brew install --cask cursor || return 1
    echo "  Cursor installed"

    return 0
}

install_cursor
