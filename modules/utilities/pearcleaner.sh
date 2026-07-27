#!/bin/bash
# modules/utilities/pearcleaner.sh - Install PearCleaner

install_pearcleaner() {
    echo "  Installing PearCleaner..."

    if app_installed "PearCleaner"; then
        echo "  PearCleaner is already installed"
        return 0
    fi

    brew install --cask pearcleaner || return 1
    echo "  PearCleaner installed"

    return 0
}

install_pearcleaner
