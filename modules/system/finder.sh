#!/bin/bash
# modules/system/finder.sh - Configuracion del Finder

configure_finder() {
    echo "  Configurando Finder..."

    # Mostrar extensiones de archivos
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Mostrar barra de ruta
    defaults write com.apple.finder ShowPathbar -bool true

    # Mostrar barra de estado
    defaults write com.apple.finder ShowStatusBar -bool true

    # Vista por defecto: Lista (Nlsv=Lista, icnv=Iconos, clmv=Columnas, glyv=Galeria)
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Buscar en carpeta actual por defecto
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # No crear archivos .DS_Store en volumenes de red
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # No crear archivos .DS_Store en volumenes USB
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Mostrar carpeta home al abrir nueva ventana
    defaults write com.apple.finder NewWindowTarget -string "PfHm"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    # Deshabilitar advertencia al cambiar extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Mostrar iconos de discos duros, servidores y medios extraibles en escritorio
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Reiniciar Finder
    killall Finder 2>/dev/null || true

    return 0
}

configure_finder
