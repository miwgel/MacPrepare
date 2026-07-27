#!/bin/bash
# modules/multimedia/obs.sh - Install OBS Studio

install_obs() {
    echo "  Installing OBS Studio..."

    if app_installed "OBS"; then
        echo "  OBS is already installed"
        return 0
    fi

    brew install --cask obs || return 1
    echo "  OBS Studio installed"

    return 0
}

install_obs
