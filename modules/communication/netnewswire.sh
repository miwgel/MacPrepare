#!/bin/bash
# modules/communication/netnewswire.sh - Install NetNewsWire

install_netnewswire() {
    echo "  Installing NetNewsWire..."

    if app_installed "NetNewsWire"; then
        echo "  NetNewsWire is already installed"
        return 0
    fi

    brew install --cask netnewswire || return 1
    echo "  NetNewsWire installed"

    return 0
}

install_netnewswire
