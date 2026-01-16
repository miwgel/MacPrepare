#!/bin/zsh
# setup-gui.sh - MacPrepare con interfaz GUI nativa usando AppleScript

set -e

SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/lib/utils.sh"

# Verificar macOS
check_macos

# Definir opciones por categoria
# Formato: "id|label|default|script"

typeset -A CATEGORIES
CATEGORIES=(
    [1_system]="⚙️ Sistema"
    [2_homebrew]="🍺 Homebrew"
    [3_languages]="🐍 Lenguajes"
    [4_terminals]="🖥️ Terminales"
    [5_development]="💻 Desarrollo"
    [6_browsers]="🌐 Navegadores"
    [7_utilities]="🛠️ Utilidades"
    [8_communication]="💬 Comunicacion"
    [9_multimedia]="🎬 Multimedia"
)

# Opciones por categoria
typeset -a SYSTEM_OPTS HOMEBREW_OPTS LANGUAGES_OPTS TERMINALS_OPTS DEV_OPTS BROWSER_OPTS UTIL_OPTS COMM_OPTS MEDIA_OPTS

SYSTEM_OPTS=(
    "Teclado Spanish Better QWERTY|modules/system/keyboard.sh"
    "Dock (36px, autohide rapido)|modules/system/dock.sh"
    "Finder (extensiones, path bar)|modules/system/finder.sh"
    "Escritorio (ocultar iconos)|modules/system/desktop.sh"
    "Ventanas (sin margenes tiles)|modules/system/windows.sh"
    "Capturas (formato HEIC)|modules/system/screenshot.sh"
    "TouchID para sudo|modules/system/terminal.sh"
)

HOMEBREW_OPTS=(
    "Homebrew + desactivar telemetria|modules/homebrew/install.sh"
)

LANGUAGES_OPTS=(
    "Python 3.11|modules/languages/python.sh:3.11"
    "Python 3.12|modules/languages/python.sh:3.12"
    "Python 3.13|modules/languages/python.sh:3.13"
    "Node.js (latest)|modules/languages/node.sh:latest"
    "Node.js 22 (para n8n)|modules/languages/node.sh:22"
)

TERMINALS_OPTS=(
    "iTerm2|modules/terminals/iterm.sh"
    "Warp|modules/terminals/warp.sh"
)

DEV_OPTS=(
    "Visual Studio Code|modules/development/vscode.sh:stable"
    "VS Code Insiders|modules/development/vscode.sh:insiders"
    "Git (actualizar)|modules/development/git.sh"
    "GitHub Desktop|modules/development/git.sh:desktop"
    "Docker|modules/development/docker.sh"
    "Platypus|modules/development/platypus.sh"
)

BROWSER_OPTS=(
    "Zen Browser|modules/browsers/zen.sh"
)

UTIL_OPTS=(
    "Sentinel|modules/utilities/sentinel.sh"
    "Keka|modules/utilities/keka.sh"
    "FFMPEG|modules/utilities/ffmpeg.sh"
    "Cloudflared|modules/utilities/cloudflared.sh"
    "SaneSideButtons|modules/utilities/sanesidebuttons.sh"
    "Resilio Sync|modules/utilities/resilio-sync.sh"
    "Little Snitch (de pago)|modules/utilities/little-snitch.sh"
)

COMM_OPTS=(
    "WhatsApp|modules/communication/whatsapp.sh"
    "Discord|modules/communication/discord.sh"
)

MEDIA_OPTS=(
    "OBS|modules/multimedia/obs.sh"
)

# Construir lista completa para AppleScript
build_applescript_list() {
    local items=""
    local separator=""

    # Sistema
    for opt in "${SYSTEM_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"⚙️ ${label}\""
        separator=", "
    done

    # Homebrew
    for opt in "${HOMEBREW_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🍺 ${label}\""
    done

    # Lenguajes
    for opt in "${LANGUAGES_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🐍 ${label}\""
    done

    # Terminales
    for opt in "${TERMINALS_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🖥️ ${label}\""
    done

    # Desarrollo
    for opt in "${DEV_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"💻 ${label}\""
    done

    # Navegadores
    for opt in "${BROWSER_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🌐 ${label}\""
    done

    # Utilidades
    for opt in "${UTIL_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🛠️ ${label}\""
    done

    # Comunicacion
    for opt in "${COMM_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"💬 ${label}\""
    done

    # Multimedia
    for opt in "${MEDIA_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🎬 ${label}\""
    done

    echo "$items"
}

# Construir lista de defaults (todos excepto Little Snitch)
build_default_selection() {
    local items=""
    local separator=""

    for opt in "${SYSTEM_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"⚙️ ${label}\""
        separator=", "
    done

    for opt in "${HOMEBREW_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🍺 ${label}\""
    done

    for opt in "${LANGUAGES_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🐍 ${label}\""
    done

    for opt in "${TERMINALS_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🖥️ ${label}\""
    done

    for opt in "${DEV_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"💻 ${label}\""
    done

    for opt in "${BROWSER_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🌐 ${label}\""
    done

    for opt in "${UTIL_OPTS[@]}"; do
        local label="${opt%%|*}"
        # Excluir Little Snitch por defecto
        [[ "$label" != *"Little Snitch"* ]] && items+="${separator}\"🛠️ ${label}\""
    done

    for opt in "${COMM_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"💬 ${label}\""
    done

    for opt in "${MEDIA_OPTS[@]}"; do
        local label="${opt%%|*}"
        items+="${separator}\"🎬 ${label}\""
    done

    echo "$items"
}

# Mapear seleccion a script
get_script_for_selection() {
    local selection="$1"
    # Quitar el emoji del inicio
    local clean_label="${selection#* }"

    # Buscar en todas las categorias
    for opt in "${SYSTEM_OPTS[@]}" "${HOMEBREW_OPTS[@]}" "${LANGUAGES_OPTS[@]}" \
               "${TERMINALS_OPTS[@]}" "${DEV_OPTS[@]}" "${BROWSER_OPTS[@]}" \
               "${UTIL_OPTS[@]}" "${COMM_OPTS[@]}" "${MEDIA_OPTS[@]}"; do
        local label="${opt%%|*}"
        local script="${opt#*|}"
        if [[ "$label" == "$clean_label" ]]; then
            echo "$script"
            return
        fi
    done
}

# Mostrar dialogo de bienvenida
show_welcome() {
    osascript <<EOF
display dialog "🍎 MacPrepare

Configura tu Mac como te gusta.

Este asistente instalará y configurará las opciones que selecciones." ¬
    with title "MacPrepare Setup" ¬
    buttons {"Cancelar", "Continuar"} ¬
    default button "Continuar" ¬
    with icon note
EOF
}

# Mostrar selector de opciones
show_selector() {
    local all_items=$(build_applescript_list)
    local default_items=$(build_default_selection)

    osascript <<EOF
set allOptions to {${all_items}}
set defaultSelection to {${default_items}}

set selectedItems to choose from list allOptions ¬
    with title "MacPrepare - Seleccionar opciones" ¬
    with prompt "Selecciona las opciones a instalar/configurar:

⚙️ Sistema  🍺 Homebrew  🐍 Lenguajes  🖥️ Terminales
💻 Desarrollo  🌐 Navegadores  🛠️ Utilidades
💬 Comunicacion  🎬 Multimedia" ¬
    default items defaultSelection ¬
    OK button name "Instalar" ¬
    cancel button name "Cancelar" ¬
    multiple selections allowed true

if selectedItems is false then
    return "CANCELLED"
else
    set AppleScript's text item delimiters to "|||"
    return selectedItems as text
end if
EOF
}

# Mostrar progreso
show_progress() {
    local message="$1"
    osascript <<EOF
display notification "$message" with title "MacPrepare" sound name "default"
EOF
}

# Mostrar resultado final
show_result() {
    local success=$1
    local total=$2
    local errors=$3

    if [[ $errors -eq 0 ]]; then
        osascript <<EOF
display dialog "✅ Instalación completada

Se configuraron $total opciones correctamente.

Algunos cambios pueden requerir reiniciar el sistema." ¬
    with title "MacPrepare - Completado" ¬
    buttons {"OK"} ¬
    default button "OK" ¬
    with icon note
EOF
    else
        osascript <<EOF
display dialog "⚠️ Instalación completada con errores

Completados: $((total - errors))/$total
Errores: $errors

Revisa el log en:
~/.macprepare-log.txt" ¬
    with title "MacPrepare - Completado con errores" ¬
    buttons {"Ver Log", "OK"} ¬
    default button "OK" ¬
    with icon caution
EOF
    fi
}

# Ejecutar instalacion
run_installation() {
    local selections="$1"

    init_log

    local total=0
    local completed=0
    local errors=0

    # Contar selecciones
    local IFS='|||'
    local items=("${(@s:|||:)selections}")
    total=${#items[@]}

    log_info "Iniciando instalacion de $total opciones"

    for selection in "${items[@]}"; do
        [[ -z "$selection" ]] && continue

        ((completed++))
        local script=$(get_script_for_selection "$selection")

        if [[ -n "$script" ]]; then
            local script_path="${script%%:*}"
            local script_arg="${script#*:}"
            [[ "$script_arg" == "$script_path" ]] && script_arg=""

            local full_script="$SCRIPT_DIR/$script_path"

            log_info "[$completed/$total] Ejecutando: $selection"

            if [[ -f "$full_script" ]]; then
                # Mostrar notificacion de progreso
                show_progress "[$completed/$total] Instalando: ${selection#* }"

                if source "$full_script" "$script_arg" >> "$LOG_FILE" 2>&1; then
                    log_success "$selection"
                else
                    log_error "$selection"
                    ((errors++))
                fi
            else
                log_error "Script no encontrado: $script_path"
                ((errors++))
            fi
        fi
    done

    show_result $completed $total $errors
}

# Main
main() {
    # Bienvenida
    local welcome_result
    welcome_result=$(show_welcome 2>&1) || {
        echo "Instalacion cancelada"
        exit 0
    }

    # Selector
    local selections
    selections=$(show_selector 2>&1)

    if [[ "$selections" == "CANCELLED" ]] || [[ -z "$selections" ]]; then
        echo "Instalacion cancelada"
        exit 0
    fi

    # Ejecutar
    run_installation "$selections"

    echo "MacPrepare finalizado"
}

main "$@"
