#!/bin/bash
# modules/menubar/one-thing.sh - Install One Thing (Mac App Store)

install_one_thing() {
    echo "  Installing One Thing..."

    if app_installed "One Thing"; then
        echo "  One Thing is already installed"
        return 0
    fi

    # One Thing is only distributed through the Mac App Store
    if ! command -v mas &> /dev/null; then
        brew install mas || return 1
    fi

    if ! mas install 1604176982; then
        echo "  Error: Mac App Store install failed (are you signed in to the App Store?)"
        return 1
    fi

    echo "  One Thing installed"

    return 0
}

install_one_thing
