#!/bin/zsh
# install.sh - Bootstrap script for MacPrepare
# Usage: zsh <(curl -fsSL https://raw.githubusercontent.com/miwgel/MacPrepare/main/install.sh)
# Debug: zsh <(curl -fsSL https://raw.githubusercontent.com/miwgel/MacPrepare/main/install.sh) --debug

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Parse arguments
DEBUG_MODE=""
for arg in "$@"; do
    case $arg in
        --debug|-d)
            DEBUG_MODE="1"
            ;;
    esac
done

# Temporary directory
TMP_DIR="$HOME/.macprepare-tmp"
REPO_URL="https://github.com/miwgel/MacPrepare.git"

echo ""
echo -e "${CYAN}🍎 MacPrepare Installer${RESET}"
[[ -n "$DEBUG_MODE" ]] && echo -e "${YELLOW}   DEBUG MODE${RESET}"
echo ""

# Check macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo -e "${RED}Error: This script only works on macOS${RESET}"
    exit 1
fi

# Check git
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git not found. Installing Command Line Tools...${RESET}"
    xcode-select --install 2>/dev/null || true
    echo "Wait for the Command Line Tools to finish installing, then run this script again."
    exit 1
fi

# Clean up the temporary directory if it exists
if [ -d "$TMP_DIR" ]; then
    [[ -n "$DEBUG_MODE" ]] && echo -e "${YELLOW}Cleaning up previous installation...${RESET}"
    rm -rf "$TMP_DIR"
fi

# Clone repository
echo -e "${GREEN}Downloading MacPrepare...${RESET}"
git clone --depth 1 "$REPO_URL" "$TMP_DIR" 2>/dev/null || {
    echo -e "${RED}Error cloning the repository${RESET}"
    exit 1
}

# Run setup
echo -e "${GREEN}Starting setup...${RESET}"
echo ""

chmod +x "$TMP_DIR/setup.sh"

if [[ -n "$DEBUG_MODE" ]]; then
    DEBUG=1 "$TMP_DIR/setup.sh"
else
    "$TMP_DIR/setup.sh"
fi

# Auto-clean temporary files
rm -rf "$TMP_DIR"

echo ""
echo -e "${GREEN}✓${RESET} MacPrepare finished"
echo ""
