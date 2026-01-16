#!/bin/bash
# modules/development/docker.sh - Instalar Docker

install_docker() {
    echo "  Instalando Docker..."

    if app_installed "Docker"; then
        echo "  Docker ya esta instalado"
        return 0
    fi

    brew install --cask docker

    echo "  Docker instalado"
    echo "  Abre Docker.app para completar la configuracion inicial"

    return 0
}

install_docker
