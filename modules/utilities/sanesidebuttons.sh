#!/bin/bash
# modules/utilities/sanesidebuttons.sh - Instalar SaneSideButtons

install_sanesidebuttons() {
    echo "  Instalando SaneSideButtons..."

    if app_installed "SaneSideButtons"; then
        echo "  SaneSideButtons ya esta instalado"
        return 0
    fi

    brew install --cask sanesidebuttons

    echo "  SaneSideButtons instalado"
    echo "  Abre la app y dale permisos de accesibilidad"

    return 0
}

install_sanesidebuttons
