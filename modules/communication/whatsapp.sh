#!/bin/bash
# modules/communication/whatsapp.sh - Install WhatsApp

install_whatsapp() {
    echo "  Installing WhatsApp..."

    if app_installed "WhatsApp"; then
        echo "  WhatsApp is already installed"
        return 0
    fi

    brew install --cask whatsapp || return 1
    echo "  WhatsApp installed"

    return 0
}

install_whatsapp
