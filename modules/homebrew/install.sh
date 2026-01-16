#!/bin/bash
# modules/homebrew/install.sh - Instalar Homebrew y deshabilitar telemetria

install_homebrew() {
    echo "  Verificando Homebrew..."

    # Verificar si ya esta instalado
    if command -v brew &> /dev/null; then
        echo "  Homebrew ya esta instalado"
    else
        echo "  Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Agregar Homebrew al PATH segun arquitectura
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    # Deshabilitar telemetria/analytics
    echo "  Deshabilitando telemetria de Homebrew..."
    brew analytics off

    # Agregar variable de entorno para deshabilitar analytics permanentemente
    if ! grep -q "HOMEBREW_NO_ANALYTICS" "$HOME/.zshrc" 2>/dev/null; then
        echo "" >> "$HOME/.zshrc"
        echo "# Deshabilitar telemetria de Homebrew" >> "$HOME/.zshrc"
        echo "export HOMEBREW_NO_ANALYTICS=1" >> "$HOME/.zshrc"
    fi

    if ! grep -q "HOMEBREW_NO_ANALYTICS" "$HOME/.zprofile" 2>/dev/null; then
        echo "" >> "$HOME/.zprofile"
        echo "export HOMEBREW_NO_ANALYTICS=1" >> "$HOME/.zprofile"
    fi

    echo "  Homebrew instalado y telemetria deshabilitada"

    return 0
}

install_homebrew
