#!/bin/bash
# modules/development/docker.sh - Install Docker

install_docker() {
    echo "  Installing Docker..."

    if app_installed "Docker"; then
        echo "  Docker is already installed"
        return 0
    fi

    brew install --cask docker || return 1
    echo "  Docker installed"
    echo "  Abre Docker.app para completar la configuracion inicial"

    return 0
}

install_docker
