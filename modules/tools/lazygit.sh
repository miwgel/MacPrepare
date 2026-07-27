#!/bin/bash
# modules/tools/lazygit.sh - Install lazygit

install_lazygit() {
    echo "  Installing lazygit..."

    if command -v lazygit &> /dev/null; then
        echo "  lazygit is already installed"
        return 0
    fi

    brew install lazygit || return 1
    echo "  lazygit installed"

    return 0
}

install_lazygit
