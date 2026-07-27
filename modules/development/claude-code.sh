#!/bin/bash
# modules/development/claude-code.sh - Install Claude Code

install_claude_code() {
    echo "  Installing Claude Code..."

    if command -v claude &> /dev/null; then
        echo "  Claude Code is already installed"
        return 0
    fi

    # Claude Code installs via curl, not brew
    if ! curl -fsSL https://claude.ai/install.sh | bash; then
        echo "  Error: Claude Code installer failed"
        return 1
    fi

    echo "  Claude Code installed"

    return 0
}

install_claude_code
