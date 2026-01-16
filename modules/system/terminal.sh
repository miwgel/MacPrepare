#!/bin/bash
# modules/system/terminal.sh - Habilitar TouchID para sudo

configure_touchid_sudo() {
    echo "  Configurando TouchID para sudo..."

    local pam_file="/etc/pam.d/sudo_local"
    local pam_line="auth       sufficient     pam_tid.so"

    # Verificar si ya esta configurado
    if [ -f "$pam_file" ] && grep -q "pam_tid.so" "$pam_file"; then
        echo "  TouchID para sudo ya esta configurado"
        return 0
    fi

    # Crear archivo sudo_local si no existe (metodo recomendado en macOS Sonoma+)
    if [ ! -f "$pam_file" ]; then
        echo "  Creando configuracion de TouchID para sudo..."
        echo "# sudo_local: archivo local de configuracion para sudo" | sudo tee "$pam_file" > /dev/null
        echo "# Habilitar TouchID para autenticacion sudo" | sudo tee -a "$pam_file" > /dev/null
        echo "$pam_line" | sudo tee -a "$pam_file" > /dev/null
    else
        # Agregar linea si el archivo existe pero no tiene la configuracion
        echo "$pam_line" | sudo tee -a "$pam_file" > /dev/null
    fi

    echo "  TouchID habilitado para sudo"
    echo "  Nota: Funciona con TouchID fisico y Apple Watch"

    return 0
}

configure_touchid_sudo
