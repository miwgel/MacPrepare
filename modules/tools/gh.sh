#!/bin/bash
# modules/tools/gh.sh - Install GitHub CLI

install_gh() {
    echo "  Installing GitHub CLI..."

    if command -v gh &> /dev/null; then
        echo "  GitHub CLI is already installed"
        return 0
    fi

    brew install gh || return 1
    echo "  GitHub CLI installed"

    return 0
}

install_gh
