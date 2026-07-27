#!/bin/bash
# modules/system/desktop.sh - Ocultar iconos del escritorio

configure_desktop() {
    echo "  Hiding desktop icons..."

    # Ocultar iconos del escritorio
    defaults write com.apple.finder CreateDesktop -bool false

    # Reiniciar Finder para aplicar
    killall Finder 2>/dev/null || true

    echo "  Desktop icons hidden"
    echo "  To revert: defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

    return 0
}

configure_desktop
