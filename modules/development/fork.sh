#!/bin/bash
# modules/development/fork.sh - Install Fork

install_fork() {
    echo "  Installing Fork..."

    if app_installed "Fork"; then
        echo "  Fork is already installed"
        return 0
    fi

    brew install --cask fork || return 1
    echo "  Fork installed"

    return 0
}

install_fork
