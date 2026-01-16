#!/bin/bash
# modules/communication/telegram.sh - Instalar Telegram

install_telegram() {
    echo "  Instalando Telegram..."

    if app_installed "Telegram"; then
        echo "  Telegram ya esta instalado"
        return 0
    fi

    brew install --cask telegram

    echo "  Telegram instalado"

    return 0
}

install_telegram
