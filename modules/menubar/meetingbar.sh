#!/bin/bash
# modules/menubar/meetingbar.sh - Install MeetingBar

install_meetingbar() {
    echo "  Installing MeetingBar..."

    if app_installed "MeetingBar"; then
        echo "  MeetingBar is already installed"
        return 0
    fi

    brew install --cask meetingbar || return 1
    echo "  MeetingBar installed"

    return 0
}

install_meetingbar
