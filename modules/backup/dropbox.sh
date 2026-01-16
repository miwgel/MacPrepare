#!/bin/bash
# modules/backup/dropbox.sh - Instalar Dropbox

install_dropbox() {
    echo "  Instalando Dropbox..."

    if app_installed "Dropbox"; then
        echo "  Dropbox ya esta instalado"
        return 0
    fi

    brew install --cask dropbox

    echo "  Dropbox instalado"

    return 0
}

install_dropbox
