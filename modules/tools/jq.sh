#!/bin/bash
# modules/tools/jq.sh - Install jq

install_jq() {
    echo "  Installing jq..."

    if command -v jq &> /dev/null; then
        echo "  jq is already installed"
        return 0
    fi

    brew install jq || return 1
    echo "  jq installed"

    return 0
}

install_jq
