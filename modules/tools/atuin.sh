#!/bin/bash
# modules/tools/atuin.sh - Install atuin

install_atuin() {
    echo "  Installing atuin..."

    if command -v atuin &> /dev/null; then
        echo "  atuin is already installed"
        return 0
    fi

    brew install atuin || return 1
    echo "  atuin installed"

    return 0
}

install_atuin
