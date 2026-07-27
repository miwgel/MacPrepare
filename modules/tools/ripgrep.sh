#!/bin/bash
# modules/tools/ripgrep.sh - Install ripgrep

install_ripgrep() {
    echo "  Installing ripgrep..."

    if command -v rg &> /dev/null; then
        echo "  ripgrep is already installed"
        return 0
    fi

    brew install ripgrep || return 1
    echo "  ripgrep installed"

    return 0
}

install_ripgrep
