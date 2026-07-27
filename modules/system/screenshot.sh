#!/bin/bash
# modules/system/screenshot.sh - Configure screenshot format

configure_screenshot() {
    echo "  Configuring screenshot options..."

    # PNG format (most compatible)
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow on window screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Sin thumbnail flotante
    defaults write com.apple.screencapture show-thumbnail -bool false

    # Carpeta personalizada ~/Screenshots
    mkdir -p ~/Screenshots
    defaults write com.apple.screencapture location ~/Screenshots

    echo "  Screenshot format: PNG"
    echo "  Window screenshot shadow: disabled"
    echo "  Floating thumbnail: disabled"
    echo "  Location: ~/Screenshots"

    return 0
}

configure_screenshot
