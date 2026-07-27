#!/bin/bash
# modules/development/tableplus.sh - Install TablePlus

install_tableplus() {
    echo "  Installing TablePlus..."

    if app_installed "TablePlus"; then
        echo "  TablePlus is already installed"
        return 0
    fi

    brew install --cask tableplus || return 1
    echo "  TablePlus installed"

    return 0
}

install_tableplus
