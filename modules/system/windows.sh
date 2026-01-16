#!/bin/bash
# modules/system/windows.sh - Configurar margenes de ventanas (tiles)

configure_windows() {
    echo "  Configurando margenes de ventanas..."

    # Eliminar margenes en ventanas tiled (macOS Sequoia+)
    # Nota: Esta configuracion esta disponible en macOS 15+
    if check_macos_version "15.0"; then
        defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
        echo "  Margenes de tiles desactivados"
    else
        echo "  Esta opcion requiere macOS Sequoia (15.0) o superior"
    fi

    return 0
}

configure_windows
