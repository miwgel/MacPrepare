# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MacPrepare is a macOS setup automation tool with a native SwiftUI GUI. It configures system preferences and installs applications via shell scripts executed through a graphical interface.

## Build & Run Commands

```bash
# Compile the GUI (auto-compiles if source newer than binary)
./setup.sh

# Manual compilation
swiftc -parse-as-library -o .build/MacPrepareGUI gui/MacPrepareGUI.swift -framework SwiftUI -framework AppKit

# Run with debug mode (shows all script output in terminal)
DEBUG=1 MACPREPARE_DIR="$(pwd)" .build/MacPrepareGUI

# Alternative debug flag
MACPREPARE_DIR="$(pwd)" .build/MacPrepareGUI --debug
```

## Architecture

### GUI Layer (`gui/MacPrepareGUI.swift`)
Single-file SwiftUI application containing:
- **Data Models**: `Option`, `Category`, `InstallItem` structs
- **AppState**: ObservableObject managing categories, installation state, and script execution
- **Views**: `SelectionView` (category grid with checkboxes), `ProgressView_Install` (installation progress)
- **Script Execution**: `executeScript()` runs shell scripts via `/bin/zsh -c "source 'path'"`

Key patterns:
- Options reference scripts via `"modules/category/script.sh"` or `"modules/category/script.sh:arg"` format
- `selected: false` marks options as OFF by default
- `paid: true` marks paid apps (auto-deselected, shown with orange label)
- `description` field provides hover tooltips

### Module Scripts (`modules/*/`)
Each category has a directory with shell scripts following this pattern:
```bash
#!/bin/bash
# modules/category/name.sh - Description

install_name() {
    echo "  Installing..."

    if app_installed "AppName"; then  # or command -v for CLI tools
        echo "  Already installed"
        return 0
    fi

    brew install --cask app-name  # or brew install for CLI

    echo "  Installed"
    return 0
}

install_name
```

System configuration scripts use `defaults write` commands and may call `killall` to apply changes.

### Utilities (`lib/utils.sh`)
Helper functions sourced by shell scripts:
- `app_installed "Name"` - checks /Applications
- `command_exists "cmd"` - checks PATH
- `check_homebrew` - verifies brew installation
- Logging functions write to `~/.macprepare-log.txt`

## Adding New Options

1. Create script in appropriate `modules/` subdirectory
2. Add `Option()` to the category in `MacPrepareGUI.swift`
3. Update column assignments in `SelectionView` if adding new categories

## Environment Variables

- `MACPREPARE_DIR`: Base directory for script paths (set automatically by setup.sh)
- `DEBUG`: Enable verbose terminal output when set to any value
