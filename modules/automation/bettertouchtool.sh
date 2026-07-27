#!/bin/bash
# modules/automation/bettertouchtool.sh - Install BetterTouchTool

install_bettertouchtool() {
    echo "  Installing BetterTouchTool..."

    if app_installed "BetterTouchTool"; then
        echo "  BetterTouchTool is already installed"
        return 0
    fi

    brew install --cask bettertouchtool || return 1
    echo "  BetterTouchTool installed"

    return 0
}

install_bettertouchtool
