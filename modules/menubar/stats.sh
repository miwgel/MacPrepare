#!/bin/bash
# modules/menubar/stats.sh - Install Stats

install_stats() {
    echo "  Installing Stats..."

    if app_installed "Stats"; then
        echo "  Stats is already installed"
        return 0
    fi

    brew install --cask stats || return 1
    echo "  Stats installed"

    return 0
}

install_stats
