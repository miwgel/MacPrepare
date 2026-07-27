#!/bin/bash
# modules/ai/lm-studio.sh - Install LM Studio

install_lm_studio() {
    echo "  Installing LM Studio..."

    if app_installed "LM Studio"; then
        echo "  LM Studio is already installed"
        return 0
    fi

    brew install --cask lm-studio || return 1
    echo "  LM Studio installed"

    return 0
}

install_lm_studio
