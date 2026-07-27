#!/bin/bash
# modules/system/screenshot.sh - Configurar formato de capturas de pantalla

configure_screenshot() {
    echo "  Configuring formato de capturas..."

    # Formato PNG (más compatible)
    defaults write com.apple.screencapture type -string "png"

    # Deshabilitar sombra en capturas de ventanas
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
