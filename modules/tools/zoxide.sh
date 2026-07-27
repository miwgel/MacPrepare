#!/bin/bash
# modules/tools/zoxide.sh - Install zoxide

install_zoxide() {
    echo "  Installing zoxide..."

    if command -v zoxide &> /dev/null; then
        echo "  zoxide is already installed"
        return 0
    fi

    brew install zoxide || return 1
    echo "  zoxide installed"

    return 0
}

install_zoxide
