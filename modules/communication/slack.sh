#!/bin/bash
# modules/communication/slack.sh - Instalar Slack

install_slack() {
    echo "  Instalando Slack..."

    if app_installed "Slack"; then
        echo "  Slack ya esta instalado"
        return 0
    fi

    brew install --cask slack

    echo "  Slack instalado"

    return 0
}

install_slack
