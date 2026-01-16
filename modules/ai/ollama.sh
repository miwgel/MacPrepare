#!/bin/bash
# modules/ai/ollama.sh - Instalar Ollama

install_ollama() {
    echo "  Instalando Ollama..."

    if command -v ollama &> /dev/null; then
        echo "  Ollama ya esta instalado"
        return 0
    fi

    brew install ollama

    echo "  Ollama instalado"

    return 0
}

install_ollama
