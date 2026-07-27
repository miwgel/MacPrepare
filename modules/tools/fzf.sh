#!/bin/bash
# modules/tools/fzf.sh - Install fzf

install_fzf() {
    echo "  Installing fzf..."

    if command -v fzf &> /dev/null; then
        echo "  fzf is already installed"
        return 0
    fi

    brew install fzf || return 1
    echo "  fzf installed"

    return 0
}

install_fzf
