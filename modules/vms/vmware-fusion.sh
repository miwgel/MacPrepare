#!/bin/bash
# modules/vms/vmware-fusion.sh - Instalar VMware Fusion

install_vmware_fusion() {
    echo "  Instalando VMware Fusion..."

    if app_installed "VMware Fusion"; then
        echo "  VMware Fusion ya esta instalado"
        return 0
    fi

    brew install --cask vmware-fusion

    echo "  VMware Fusion instalado"

    return 0
}

install_vmware_fusion
