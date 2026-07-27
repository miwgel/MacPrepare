#!/bin/bash
# modules/system/input.sh - Desactivar autocorrección y funciones automáticas

configure_input() {
    echo "  Configuring entrada de texto..."

    # Desactivar autocorrección
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Desactivar smart dashes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Desactivar smart quotes
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Desactivar capitalización automática
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    echo "  Autocorrection: disabled"
    echo "  Smart dashes: disabled"
    echo "  Smart quotes: disabled"
    echo "  Auto-capitalization: disabled"

    return 0
}

configure_input
