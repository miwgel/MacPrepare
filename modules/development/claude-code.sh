#!/bin/bash
# modules/development/claude-code.sh - Instalar Claude Code

install_claude_code() {
    echo "  Instalando Claude Code..."

    if command -v claude &> /dev/null; then
        echo "  Claude Code ya esta instalado"
        return 0
    fi

    # Claude Code se instala via curl, no brew
    curl -fsSL https://claude.ai/install.sh | bash

    echo "  Claude Code instalado"

    return 0
}

install_claude_code
