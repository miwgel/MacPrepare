#!/bin/bash
# modules/utilities/sanesidebuttons.sh - Install SaneSideButtons

install_sanesidebuttons() {
    echo "  Installing SaneSideButtons..."

    if app_installed "SaneSideButtons"; then
        echo "  SaneSideButtons is already installed"
        return 0
    fi

    brew install --cask sanesidebuttons || return 1
    echo "  SaneSideButtons installed"
    echo "  Open the app and grant it Accessibility permissions"

    return 0
}

install_sanesidebuttons
