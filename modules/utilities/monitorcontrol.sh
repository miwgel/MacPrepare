#!/bin/bash
# modules/utilities/monitorcontrol.sh - Install MonitorControl

install_monitorcontrol() {
    echo "  Installing MonitorControl..."

    if app_installed "MonitorControl"; then
        echo "  MonitorControl is already installed"
        return 0
    fi

    brew install --cask monitorcontrol || return 1
    echo "  MonitorControl installed"

    return 0
}

install_monitorcontrol
