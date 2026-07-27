#!/bin/bash
# modules/tools/btop.sh - Install btop

install_btop() {
    echo "  Installing btop..."

    if command -v btop &> /dev/null; then
        echo "  btop is already installed"
        return 0
    fi

    brew install btop || return 1
    echo "  btop installed"

    return 0
}

install_btop
