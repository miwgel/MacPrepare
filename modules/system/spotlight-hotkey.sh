#!/bin/bash
# modules/system/spotlight-hotkey.sh - Desactivar hotkey de Spotlight (⌘Space)
# Útil para usar Raycast u otro launcher con ⌘Space

disable_spotlight_hotkey() {
    echo "  Desactivando hotkey de Spotlight (⌘Space)..."

    local plist="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"

    # Eliminar key 64 si existe (para recrearlo limpio)
    /usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:64" "$plist" 2>/dev/null || true

    # Crear key 64 desactivado con parámetros "sin tecla"
    /usr/libexec/PlistBuddy \
        -c "Add :AppleSymbolicHotKeys:64 dict" \
        -c "Add :AppleSymbolicHotKeys:64:enabled bool false" \
        -c "Add :AppleSymbolicHotKeys:64:value dict" \
        -c "Add :AppleSymbolicHotKeys:64:value:type string standard" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters array" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters:0 integer 65535" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters:1 integer 65535" \
        -c "Add :AppleSymbolicHotKeys:64:value:parameters:2 integer 0" \
        "$plist"

    # Aplicar cambios
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    echo "  Hotkey de Spotlight desactivado"
    echo "  Nota: Puede requerir cerrar sesión para aplicar completamente"

    return 0
}

disable_spotlight_hotkey
