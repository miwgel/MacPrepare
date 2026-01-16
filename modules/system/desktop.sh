#!/bin/bash
# modules/system/desktop.sh - Ocultar iconos del escritorio

configure_desktop() {
    echo "  Ocultando iconos del escritorio..."

    # Ocultar iconos del escritorio
    defaults write com.apple.finder CreateDesktop -bool false

    # Reiniciar Finder para aplicar
    killall Finder 2>/dev/null || true

    echo "  Iconos del escritorio ocultados"
    echo "  Para revertir: defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

    return 0
}

configure_desktop
