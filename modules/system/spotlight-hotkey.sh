#!/bin/bash
# modules/system/spotlight-hotkey.sh - Disable Spotlight hotkeys (⌘Space and ⌘⌥Space)
# Useful to free up ⌘Space for Raycast or another launcher
# Must run as the logged-in user (NOT root): uses per-user defaults via cfprefsd

disable_spotlight_hotkey() {
    echo "  Disabling Spotlight hotkeys (⌘Space and ⌘⌥Space)..."

    local disabled_entry='<dict><key>enabled</key><false/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>65535</integer><integer>65535</integer><integer>0</integer></array></dict></dict>'

    # Key 64: Show Spotlight search (⌘Space)
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "$disabled_entry" || return 1

    # Key 65: Show Spotlight window (⌘⌥Space)
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "$disabled_entry" || return 1

    # Apply changes
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    echo "  Spotlight hotkeys disabled"
    echo "  Note: You may need to log out for this to fully apply"

    return 0
}

disable_spotlight_hotkey
