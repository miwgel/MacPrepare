#!/bin/zsh
# install.sh - Bootstrap script para MacPrepare
# Uso: zsh <(curl -fsSL https://raw.githubusercontent.com/miwgel/MacPrepare/main/install.sh)
# Debug: zsh <(curl -fsSL https://raw.githubusercontent.com/miwgel/MacPrepare/main/install.sh) --debug

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Parsear argumentos
DEBUG_MODE=""
for arg in "$@"; do
    case $arg in
        --debug|-d)
            DEBUG_MODE="1"
            ;;
    esac
done

# Directorio temporal
TMP_DIR="$HOME/.macprepare-tmp"
REPO_URL="https://github.com/miwgel/MacPrepare.git"

echo ""
echo -e "${CYAN}🍎 MacPrepare Installer${RESET}"
[[ -n "$DEBUG_MODE" ]] && echo -e "${YELLOW}   DEBUG MODE${RESET}"
echo ""

# Verificar macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}Error: Este script solo funciona en macOS${RESET}"
    exit 1
fi

# Verificar git
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git no encontrado. Instalando Command Line Tools...${RESET}"
    xcode-select --install 2>/dev/null || true
    echo "Espera a que terminen de instalarse las Command Line Tools y vuelve a ejecutar este script."
    exit 1
fi

# Limpiar directorio temporal si existe
if [ -d "$TMP_DIR" ]; then
    [[ -n "$DEBUG_MODE" ]] && echo -e "${YELLOW}Limpiando instalacion anterior...${RESET}"
    rm -rf "$TMP_DIR"
fi

# Clonar repositorio
echo -e "${GREEN}Descargando MacPrepare...${RESET}"
git clone --depth 1 "$REPO_URL" "$TMP_DIR" 2>/dev/null || {
    echo -e "${RED}Error clonando el repositorio${RESET}"
    exit 1
}

# Ejecutar setup
echo -e "${GREEN}Iniciando configuracion...${RESET}"
echo ""

chmod +x "$TMP_DIR/setup.sh"

if [[ -n "$DEBUG_MODE" ]]; then
    DEBUG=1 "$TMP_DIR/setup.sh"
else
    "$TMP_DIR/setup.sh"
fi

# Auto-limpiar archivos temporales
rm -rf "$TMP_DIR"

echo ""
echo -e "${GREEN}✓${RESET} MacPrepare finalizado"
echo ""
