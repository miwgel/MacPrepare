#!/bin/bash
# modules/communication/whatsapp.sh - Instalar WhatsApp

install_whatsapp() {
    echo "  Instalando WhatsApp..."

    if app_installed "WhatsApp"; then
        echo "  WhatsApp ya esta instalado"
        return 0
    fi

    brew install --cask whatsapp

    echo "  WhatsApp instalado"

    return 0
}

install_whatsapp
