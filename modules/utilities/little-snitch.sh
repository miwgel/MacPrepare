#!/bin/bash
# modules/utilities/little-snitch.sh - Instalar Little Snitch (de pago)

install_little_snitch() {
    echo "  Instalando Little Snitch..."

    if app_installed "Little Snitch"; then
        echo "  Little Snitch ya esta instalado"
        return 0
    fi

    brew install --cask little-snitch

    echo "  Little Snitch instalado"
    echo "  Nota: Requiere licencia de pago para funcionar completamente"

    return 0
}

install_little_snitch
