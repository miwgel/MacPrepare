#!/bin/bash
# modules/security/tailscale.sh - Install Tailscale

install_tailscale() {
    echo "  Installing Tailscale..."

    if app_installed "Tailscale"; then
        echo "  Tailscale is already installed"
        return 0
    fi

    brew install --cask tailscale-app || return 1
    echo "  Tailscale installed"

    return 0
}

install_tailscale
