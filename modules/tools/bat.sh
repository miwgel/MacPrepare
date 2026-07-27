#!/bin/bash
# modules/tools/bat.sh - Install bat

install_bat() {
    echo "  Installing bat..."

    if command -v bat &> /dev/null; then
        echo "  bat is already installed"
        return 0
    fi

    brew install bat || return 1
    echo "  bat installed"

    return 0
}

install_bat
