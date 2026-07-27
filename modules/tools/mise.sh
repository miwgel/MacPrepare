#!/bin/bash
# modules/tools/mise.sh - Install mise

install_mise() {
    echo "  Installing mise..."

    if command -v mise &> /dev/null; then
        echo "  mise is already installed"
        return 0
    fi

    brew install mise || return 1
    echo "  mise installed"

    return 0
}

install_mise
