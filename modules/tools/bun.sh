#!/bin/bash
# modules/tools/bun.sh - Install bun (runtime JS/TS moderno)

install_bun() {
    echo "  Installing bun..."

    if command -v bun &> /dev/null; then
        echo "  bun is already installed"
        return 0
    fi

    brew install bun || return 1
    echo "  bun installed"

    return 0
}

install_bun
