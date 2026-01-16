#!/bin/bash
# modules/browsers/chrome.sh - Instalar Google Chrome

install_chrome() {
    echo "  Instalando Google Chrome..."

    if app_installed "Google Chrome"; then
        echo "  Google Chrome ya esta instalado"
        return 0
    fi

    brew install --cask google-chrome

    echo "  Google Chrome instalado"

    return 0
}

install_chrome
