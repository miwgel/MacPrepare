#!/bin/bash
# modules/design/pika.sh - Install Pika

install_pika() {
    echo "  Installing Pika..."

    if app_installed "Pika"; then
        echo "  Pika is already installed"
        return 0
    fi

    brew install --cask pika || return 1
    echo "  Pika installed"

    return 0
}

install_pika
