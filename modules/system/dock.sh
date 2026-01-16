#!/bin/bash
# modules/system/dock.sh - Configuracion del Dock

configure_dock() {
    echo "  Configurando Dock..."

    # Tamano del dock: 36px
    defaults write com.apple.dock tilesize -int 36

    # Autohide
    defaults write com.apple.dock autohide -bool true

    # Delay de autohide reducido
    defaults write com.apple.dock autohide-delay -float 0

    # Velocidad de animacion de autohide
    defaults write com.apple.dock autohide-time-modifier -float 0.3

    # Minimizar ventanas con efecto escala
    defaults write com.apple.dock mineffect -string "scale"

    # Mostrar indicador de apps abiertas
    defaults write com.apple.dock show-process-indicators -bool true

    # No mostrar apps recientes en el Dock
    defaults write com.apple.dock show-recents -bool false

    # Reiniciar Dock para aplicar cambios
    killall Dock 2>/dev/null || true

    return 0
}

configure_dock
