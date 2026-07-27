#!/bin/bash
# modules/tools/fd.sh - Install fd

install_fd() {
    echo "  Installing fd..."

    if command -v fd &> /dev/null; then
        echo "  fd is already installed"
        return 0
    fi

    brew install fd || return 1
    echo "  fd installed"

    return 0
}

install_fd
