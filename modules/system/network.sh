#!/bin/bash
# modules/system/network.sh - Configurar opciones de red

configure_network() {
    echo "  Configuring opciones de red..."

    # No crear .DS_Store en volúmenes de red
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # No crear .DS_Store en USB
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # AirDrop sobre Ethernet
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    # No ofrecer discos nuevos para Time Machine
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    echo "  .DS_Store on network volumes: disabled"
    echo "  .DS_Store on USB volumes: disabled"
    echo "  AirDrop over Ethernet: enabled"
    echo "  Time Machine prompt for new disks: disabled"

    return 0
}

configure_network
