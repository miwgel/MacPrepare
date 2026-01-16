#!/bin/bash
# modules/ai/lm-studio.sh - Instalar LM Studio

install_lm_studio() {
    echo "  Instalando LM Studio..."

    if app_installed "LM Studio"; then
        echo "  LM Studio ya esta instalado"
        return 0
    fi

    brew install --cask lm-studio

    echo "  LM Studio instalado"

    return 0
}

install_lm_studio
