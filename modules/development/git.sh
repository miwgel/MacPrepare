#!/bin/bash
# modules/development/git.sh - Instalar/actualizar Git y GitHub Desktop

install_git() {
    local variant="${1:-git}"

    if [ "$variant" = "desktop" ]; then
        echo "  Instalando GitHub Desktop..."

        if app_installed "GitHub Desktop"; then
            echo "  GitHub Desktop ya esta instalado"
            return 0
        fi

        brew install --cask github

        echo "  GitHub Desktop instalado"
    else
        echo "  Actualizando Git..."

        # Instalar/actualizar git via Homebrew (mas reciente que el de macOS)
        brew install git

        echo "  Git actualizado a: $(git --version)"
    fi

    return 0
}

install_git "$1"
