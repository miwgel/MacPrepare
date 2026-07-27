#!/bin/bash
# modules/utilities/appcleaner.sh - Install AppCleaner

install_appcleaner() {
    echo "  Installing AppCleaner..."

    if app_installed "AppCleaner"; then
        echo "  AppCleaner is already installed"
        return 0
    fi

    brew install --cask appcleaner || return 1
    echo "  AppCleaner installed"

    return 0
}

install_appcleaner
