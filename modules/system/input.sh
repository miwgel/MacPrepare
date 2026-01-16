#!/bin/bash
# modules/system/input.sh - Desactivar autocorrección y funciones automáticas

configure_input() {
    echo "  Configurando entrada de texto..."

    # Desactivar autocorrección
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Desactivar smart dashes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Desactivar smart quotes
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Desactivar capitalización automática
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    echo "  Autocorrección: desactivada"
    echo "  Smart dashes: desactivados"
    echo "  Smart quotes: desactivados"
    echo "  Capitalización automática: desactivada"

    return 0
}

configure_input
