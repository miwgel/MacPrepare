#!/bin/bash
# modules/system/dialogs.sh - Configurar diálogos del sistema

configure_dialogs() {
    echo "  Configurando diálogos..."

    # Expandir diálogo de guardar por defecto
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expandir diálogo de imprimir por defecto
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Guardar en disco local por defecto (no iCloud)
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    echo "  Diálogo de guardar: expandido por defecto"
    echo "  Diálogo de imprimir: expandido por defecto"
    echo "  Guardar por defecto: disco local (no iCloud)"

    return 0
}

configure_dialogs
