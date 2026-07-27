#!/bin/bash
# modules/productivity/libreoffice.sh - Install LibreOffice

install_libreoffice() {
    echo "  Installing LibreOffice..."

    if app_installed "LibreOffice"; then
        echo "  LibreOffice is already installed"
        return 0
    fi

    brew install --cask libreoffice || return 1
    echo "  LibreOffice installed"

    return 0
}

install_libreoffice
