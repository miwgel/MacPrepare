#!/bin/bash
# modules/automation/keyboard-maestro.sh - Instalar Keyboard Maestro

install_keyboard_maestro() {
    echo "  Instalando Keyboard Maestro..."

    if app_installed "Keyboard Maestro"; then
        echo "  Keyboard Maestro ya esta instalado"
        return 0
    fi

    brew install --cask keyboard-maestro

    echo "  Keyboard Maestro instalado"

    return 0
}

install_keyboard_maestro
