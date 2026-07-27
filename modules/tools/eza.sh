#!/bin/bash
# modules/tools/eza.sh - Install eza

install_eza() {
    echo "  Installing eza..."

    if command -v eza &> /dev/null; then
        echo "  eza is already installed"
        return 0
    fi

    brew install eza || return 1
    echo "  eza installed"

    return 0
}

install_eza
