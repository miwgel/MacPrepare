#!/bin/bash
# modules/menubar/itsycal.sh - Install Itsycal

install_itsycal() {
    echo "  Installing Itsycal..."

    if app_installed "Itsycal"; then
        echo "  Itsycal is already installed"
        return 0
    fi

    brew install --cask itsycal || return 1
    echo "  Itsycal installed"

    return 0
}

install_itsycal
