#!/bin/bash
# modules/communication/telegram.sh - Install Telegram

install_telegram() {
    echo "  Installing Telegram..."

    if app_installed "Telegram"; then
        echo "  Telegram is already installed"
        return 0
    fi

    brew install --cask telegram || return 1
    echo "  Telegram installed"

    return 0
}

install_telegram
