#!/bin/bash
# modules/utilities/cloudflared.sh - Instalar Cloudflared

install_cloudflared() {
    echo "  Instalando Cloudflared..."

    if command_exists cloudflared; then
        echo "  Cloudflared ya esta instalado"
        return 0
    fi

    brew install cloudflared

    echo "  Cloudflared instalado"
    echo "  Usa 'cloudflared tunnel login' para autenticarte"

    return 0
}

install_cloudflared
