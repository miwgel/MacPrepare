#!/bin/bash
# modules/utilities/little-snitch.sh - Install Little Snitch (de pago)

install_little_snitch() {
    echo "  Installing Little Snitch..."

    if app_installed "Little Snitch"; then
        echo "  Little Snitch is already installed"
        return 0
    fi

    brew install --cask little-snitch || return 1
    echo "  Little Snitch installed"
    echo "  Note: Requires a paid license for full functionality"

    return 0
}

install_little_snitch
