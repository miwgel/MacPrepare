#!/bin/bash
# modules/tools/bun.sh - Instalar bun (runtime JS/TS moderno)

install_bun() {
    echo "  Instalando bun..."

    if command -v bun &> /dev/null; then
        echo "  bun ya esta instalado"
        return 0
    fi

    brew install bun

    echo "  bun instalado"

    return 0
}

install_bun
