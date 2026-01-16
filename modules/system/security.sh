#!/bin/bash
# modules/system/security.sh - Configurar seguridad del sistema

configure_security() {
    echo "  Configurando seguridad..."

    # Password inmediato tras sleep/screensaver
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    echo "  Password requerido inmediatamente tras sleep/screensaver"

    return 0
}

configure_security
