#!/bin/zsh
# setup.sh - MacPrepare with native SwiftUI GUI

set -e

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/lib/utils.sh"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Check macOS
check_macos

# Paths
GUI_SOURCE="$SCRIPT_DIR/gui/MacPrepareGUI.swift"
GUI_BINARY="$SCRIPT_DIR/.build/MacPrepareGUI"

# Check that the GUI source exists
if [[ ! -f "$GUI_SOURCE" ]]; then
    echo -e "${RED}Error: GUI source code not found${RESET}"
    exit 1
fi

# Compile GUI if needed
compile_gui() {
    mkdir -p "$SCRIPT_DIR/.build"

    # Only recompile if the source is newer than the binary
    if [[ ! -f "$GUI_BINARY" ]] || [[ "$GUI_SOURCE" -nt "$GUI_BINARY" ]]; then
        echo -e "${CYAN}Compiling graphical interface...${RESET}"

        if ! swiftc -o "$GUI_BINARY" "$GUI_SOURCE" \
            -framework SwiftUI \
            -framework AppKit \
            -parse-as-library \
            2>/dev/null; then
            echo -e "${RED}Error: Could not compile the GUI${RESET}"
            echo -e "${YELLOW}Make sure Xcode Command Line Tools are installed:${RESET}"
            echo "  xcode-select --install"
            exit 1
        fi

        echo -e "${GREEN}✓${RESET} Compilation complete"
    fi
}

# Main
main() {
    echo -e "${BOLD}🍎 MacPrepare${RESET}"
    echo ""

    compile_gui

    # Run GUI with the script directory as an environment variable
    # Pass DEBUG through if defined
    MACPREPARE_DIR="$SCRIPT_DIR" DEBUG="$DEBUG" "$GUI_BINARY"

    echo ""
    echo -e "${GREEN}✓${RESET} MacPrepare finished"
}

main "$@"
