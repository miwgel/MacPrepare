#!/bin/bash
# modules/utilities/appcleaner.sh - Instalar AppCleaner

install_appcleaner() {
    echo "  Instalando AppCleaner..."

    if app_installed "AppCleaner"; then
        echo "  AppCleaner ya esta instalado"
        return 0
    fi

    brew install --cask appcleaner

    echo "  AppCleaner instalado"

    return 0
}

install_appcleaner
