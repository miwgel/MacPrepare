#!/bin/bash
# modules/tools/starship.sh - Install starship

install_starship() {
    echo "  Installing starship..."

    if command -v starship &> /dev/null; then
        echo "  starship is already installed"
        return 0
    fi

    brew install starship || return 1
    echo "  starship installed"

    return 0
}

install_starship
