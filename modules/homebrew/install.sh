#!/bin/bash
# modules/homebrew/install.sh - Install Homebrew and disable telemetry

install_homebrew() {
    echo "  Checking Homebrew..."

    # Check if already installed
    if command -v brew &> /dev/null; then
        echo "  Homebrew is already installed"
    else
        echo "  Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return 1

        # Add Homebrew to PATH depending on architecture
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    # Disable telemetry/analytics
    echo "  Disabling Homebrew telemetry..."
    brew analytics off

    # Environment variable to permanently disable analytics
    if ! grep -q "HOMEBREW_NO_ANALYTICS" "$HOME/.zshrc" 2>/dev/null; then
        echo "" >> "$HOME/.zshrc"
        echo "# Disable Homebrew telemetry" >> "$HOME/.zshrc"
        echo "export HOMEBREW_NO_ANALYTICS=1" >> "$HOME/.zshrc"
    fi

    if ! grep -q "HOMEBREW_NO_ANALYTICS" "$HOME/.zprofile" 2>/dev/null; then
        echo "" >> "$HOME/.zprofile"
        echo "export HOMEBREW_NO_ANALYTICS=1" >> "$HOME/.zprofile"
    fi

    echo "  Homebrew installed and telemetry disabled"

    return 0
}

install_homebrew
