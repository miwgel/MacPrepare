#!/bin/bash
# modules/design/imageoptim.sh - Install ImageOptim

install_imageoptim() {
    echo "  Installing ImageOptim..."

    if app_installed "ImageOptim"; then
        echo "  ImageOptim is already installed"
        return 0
    fi

    brew install --cask imageoptim || return 1
    echo "  ImageOptim installed"

    return 0
}

install_imageoptim
