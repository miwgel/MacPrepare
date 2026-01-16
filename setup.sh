#!/bin/zsh
# setup.sh - MacPrepare con GUI nativa SwiftUI

set -e

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/lib/utils.sh"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Verificar macOS
check_macos

# Paths
GUI_SOURCE="$SCRIPT_DIR/gui/MacPrepareGUI.swift"
GUI_BINARY="$SCRIPT_DIR/.build/MacPrepareGUI"

# Verificar que existe el código fuente
if [[ ! -f "$GUI_SOURCE" ]]; then
    echo -e "${RED}Error: No se encontró el código fuente de la GUI${RESET}"
    exit 1
fi

# Compilar GUI si es necesario
compile_gui() {
    mkdir -p "$SCRIPT_DIR/.build"

    # Solo recompilar si el fuente es más nuevo que el binario
    if [[ ! -f "$GUI_BINARY" ]] || [[ "$GUI_SOURCE" -nt "$GUI_BINARY" ]]; then
        echo -e "${CYAN}Compilando interfaz gráfica...${RESET}"

        if ! swiftc -o "$GUI_BINARY" "$GUI_SOURCE" \
            -framework SwiftUI \
            -framework AppKit \
            -parse-as-library \
            2>/dev/null; then
            echo -e "${RED}Error: No se pudo compilar la GUI${RESET}"
            echo -e "${YELLOW}Asegúrate de tener las Xcode Command Line Tools instaladas:${RESET}"
            echo "  xcode-select --install"
            exit 1
        fi

        echo -e "${GREEN}✓${RESET} Compilación completada"
    fi
}

# Main
main() {
    echo -e "${BOLD}🍎 MacPrepare${RESET}"
    echo ""

    compile_gui

    # Ejecutar GUI con el directorio del script como variable de entorno
    MACPREPARE_DIR="$SCRIPT_DIR" "$GUI_BINARY"

    echo ""
    echo -e "${GREEN}✓${RESET} MacPrepare finalizado"
}

main "$@"
