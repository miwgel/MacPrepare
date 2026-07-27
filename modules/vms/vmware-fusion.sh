#!/bin/bash
# modules/vms/vmware-fusion.sh - VMware Fusion (manual download)

install_vmware_fusion() {
    echo "  VMware Fusion..."

    if app_installed "VMware Fusion"; then
        echo "  VMware Fusion is already installed"
        return 0
    fi

    # No Homebrew cask currently exists; requires a Broadcom account download
    echo "  VMware Fusion is no longer available via Homebrew."
    echo "  Opening the vendor download page - complete the download manually."
    open "https://support.broadcom.com/group/ecx/productdownloads?subfamily=VMware%20Fusion" || return 1

    return 0
}

install_vmware_fusion
