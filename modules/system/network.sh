#!/bin/bash
# modules/system/network.sh - Configurar opciones de red

configure_network() {
    echo "  Configurando opciones de red..."

    # No crear .DS_Store en volúmenes de red
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # No crear .DS_Store en USB
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # AirDrop sobre Ethernet
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    # No ofrecer discos nuevos para Time Machine
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    echo "  .DS_Store en red: desactivado"
    echo "  .DS_Store en USB: desactivado"
    echo "  AirDrop sobre Ethernet: activado"
    echo "  Oferta Time Machine para discos nuevos: desactivada"

    return 0
}

configure_network
