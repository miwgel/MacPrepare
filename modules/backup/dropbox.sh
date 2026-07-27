#!/bin/bash
# modules/backup/dropbox.sh - Install Dropbox

install_dropbox() {
    echo "  Installing Dropbox..."

    if app_installed "Dropbox"; then
        echo "  Dropbox is already installed"
        return 0
    fi

    brew install --cask dropbox || return 1
    echo "  Dropbox installed"

    return 0
}

install_dropbox
