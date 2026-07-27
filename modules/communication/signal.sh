#!/bin/bash
# modules/communication/signal.sh - Install Signal

install_signal() {
    echo "  Installing Signal..."

    if app_installed "Signal"; then
        echo "  Signal is already installed"
        return 0
    fi

    brew install --cask signal || return 1
    echo "  Signal installed"

    return 0
}

install_signal
