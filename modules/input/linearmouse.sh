#!/bin/bash
# modules/input/linearmouse.sh - Instalar LinearMouse

install_linearmouse() {
    echo "  Instalando LinearMouse..."

    if app_installed "LinearMouse"; then
        echo "  LinearMouse ya esta instalado"
        return 0
    fi

    brew install --cask linearmouse

    echo "  LinearMouse instalado"

    return 0
}

install_linearmouse
