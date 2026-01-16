#!/bin/bash
# modules/vms/utm.sh - Instalar UTM

install_utm() {
    echo "  Instalando UTM..."

    if app_installed "UTM"; then
        echo "  UTM ya esta instalado"
        return 0
    fi

    brew install --cask utm

    echo "  UTM instalado"

    return 0
}

install_utm
