#!/bin/bash
# modules/vms/utm.sh - Install UTM

install_utm() {
    echo "  Installing UTM..."

    if app_installed "UTM"; then
        echo "  UTM is already installed"
        return 0
    fi

    brew install --cask utm || return 1
    echo "  UTM installed"

    return 0
}

install_utm
