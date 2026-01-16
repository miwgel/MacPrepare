#!/bin/bash
# modules/communication/signal.sh - Instalar Signal

install_signal() {
    echo "  Instalando Signal..."

    if app_installed "Signal"; then
        echo "  Signal ya esta instalado"
        return 0
    fi

    brew install --cask signal

    echo "  Signal instalado"

    return 0
}

install_signal
