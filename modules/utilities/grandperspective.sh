#!/bin/bash
# modules/utilities/grandperspective.sh - Install GrandPerspective

install_grandperspective() {
    echo "  Installing GrandPerspective..."

    if app_installed "GrandPerspective"; then
        echo "  GrandPerspective is already installed"
        return 0
    fi

    brew install --cask grandperspective || return 1
    echo "  GrandPerspective installed"

    return 0
}

install_grandperspective
