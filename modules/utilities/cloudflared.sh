#!/bin/bash
# modules/utilities/cloudflared.sh - Install Cloudflared

install_cloudflared() {
    echo "  Installing Cloudflared..."

    if command_exists cloudflared; then
        echo "  Cloudflared is already installed"
        return 0
    fi

    brew install cloudflared || return 1
    echo "  Cloudflared installed"
    echo "  Use 'cloudflared tunnel login' to authenticate"

    return 0
}

install_cloudflared
