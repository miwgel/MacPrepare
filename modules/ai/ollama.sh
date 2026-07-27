#!/bin/bash
# modules/ai/ollama.sh - Install Ollama

install_ollama() {
    echo "  Installing Ollama..."

    if command -v ollama &> /dev/null; then
        echo "  Ollama is already installed"
        return 0
    fi

    brew install ollama || return 1
    echo "  Ollama installed"

    return 0
}

install_ollama
