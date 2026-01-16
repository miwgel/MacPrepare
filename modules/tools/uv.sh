#!/bin/bash
# modules/tools/uv.sh - Instalar uv (gestor ultrarrápido de Python)

install_uv() {
    echo "  Instalando uv..."

    if command -v uv &> /dev/null; then
        echo "  uv ya esta instalado"
        return 0
    fi

    brew install uv

    echo "  uv instalado"

    return 0
}

install_uv
