#!/bin/bash
# modules/tools/git-delta.sh - Install git-delta

install_git_delta() {
    echo "  Installing git-delta..."

    if command -v delta &> /dev/null; then
        echo "  git-delta is already installed"
        return 0
    fi

    brew install git-delta || return 1
    echo "  git-delta installed"

    return 0
}

install_git_delta
