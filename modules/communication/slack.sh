#!/bin/bash
# modules/communication/slack.sh - Install Slack

install_slack() {
    echo "  Installing Slack..."

    if app_installed "Slack"; then
        echo "  Slack is already installed"
        return 0
    fi

    brew install --cask slack || return 1
    echo "  Slack installed"

    return 0
}

install_slack
