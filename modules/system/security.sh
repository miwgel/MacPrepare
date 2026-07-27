#!/bin/bash
# modules/system/security.sh - Configure system security

configure_security() {
    echo "  Configuring seguridad..."

    # Password inmediato tras sleep/screensaver
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    echo "  Password required immediately after sleep/screensaver"

    return 0
}

configure_security
