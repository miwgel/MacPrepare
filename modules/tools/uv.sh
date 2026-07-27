#!/bin/bash
# modules/tools/uv.sh - Install uv (gestor ultrarrápido de Python)

install_uv() {
    echo "  Installing uv..."

    if command -v uv &> /dev/null; then
        echo "  uv is already installed"
        return 0
    fi

    brew install uv || return 1
    echo "  uv installed"

    return 0
}

install_uv
