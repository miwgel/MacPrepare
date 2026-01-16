#!/bin/bash
# modules/security/oversight.sh - Instalar Oversight

install_oversight() {
    echo "  Instalando Oversight..."

    if app_installed "OverSight"; then
        echo "  Oversight ya esta instalado"
        return 0
    fi

    brew install --cask oversight

    echo "  Oversight instalado"

    return 0
}

install_oversight
