#!/bin/zsh
# modules/system/keyboard.sh - Instalar teclado Spanish Better QWERTY

install_keyboard() {
    local keyboard_dir="$HOME/Library/Keyboard Layouts"
    local keylayout_url="https://github.com/miwgel/Spanish-Better-QWERTY-Layout/raw/main/spanish-(better-QWERTY).keylayout"

    echo "  Instalando teclado Spanish Better QWERTY..."

    # Crear directorio si no existe
    mkdir -p "$keyboard_dir"

    # Descargar el archivo .keylayout directamente
    local dest_file="$keyboard_dir/spanish-(better-QWERTY).keylayout"
    if curl -fsSL "$keylayout_url" -o "$dest_file"; then
        echo "  Teclado instalado. Activar en: Preferencias > Teclado > Fuentes de entrada > + > Otros"
        return 0
    else
        echo "  Error descargando el teclado"
        return 1
    fi
}

install_keyboard
