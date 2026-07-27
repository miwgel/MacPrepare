#!/bin/bash
# modules/utilities/aldente.sh - Install AlDente

install_aldente() {
    echo "  Installing AlDente..."

    if app_installed "AlDente"; then
        echo "  AlDente is already installed"
        return 0
    fi

    brew install --cask aldente || return 1
    echo "  AlDente installed"

    return 0
}

install_aldente
