#!/bin/zsh
# lib/ui.sh - Funciones de interfaz TUI

# Colores ANSI
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly GRAY='\033[0;90m'
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly RESET='\033[0m'

# Caracteres de caja
readonly BOX_TL='┌'
readonly BOX_TR='┐'
readonly BOX_BL='└'
readonly BOX_BR='┘'
readonly BOX_H='─'
readonly BOX_V='│'
readonly BOX_CROSS='┼'
readonly BOX_T_DOWN='┬'
readonly BOX_T_UP='┴'
readonly BOX_T_RIGHT='├'
readonly BOX_T_LEFT='┤'

# Dimensiones
readonly WIDTH=56

# Ocultar/mostrar cursor
hide_cursor() {
    printf '\033[?25l'
}

show_cursor() {
    printf '\033[?25h'
}

# Limpiar pantalla y mover cursor al inicio
clear_screen() {
    printf '\033[2J\033[H'
}

# Mover cursor a posicion
move_cursor() {
    local row=$1 col=$2
    printf '\033[%d;%dH' "$row" "$col"
}

# Dibujar linea horizontal
draw_line() {
    local char="${1:-$BOX_H}"
    local width="${2:-$WIDTH}"
    local line=""
    for ((i=0; i<width-2; i++)); do
        line+="$char"
    done
    echo "$line"
}

# Dibujar borde superior
draw_top_border() {
    echo "${BOX_TL}$(draw_line)${BOX_TR}"
}

# Dibujar borde inferior
draw_bottom_border() {
    echo "${BOX_BL}$(draw_line)${BOX_BR}"
}

# Dibujar separador
draw_separator() {
    echo "${BOX_T_RIGHT}$(draw_line)${BOX_T_LEFT}"
}

# Centrar texto
center_text() {
    local text="$1"
    local width="${2:-$((WIDTH-4))}"
    local text_len=${#text}
    local padding=$(( (width - text_len) / 2 ))
    local result=""
    for ((i=0; i<padding; i++)); do
        result+=" "
    done
    result+="$text"
    local current_len=${#result}
    while [ $current_len -lt $width ]; do
        result+=" "
        current_len=${#result}
    done
    echo "$result"
}

# Padding derecho
pad_right() {
    local text="$1"
    local width="${2:-$((WIDTH-4))}"
    local text_len=${#text}
    local result="$text"
    while [ ${#result} -lt $width ]; do
        result+=" "
    done
    echo "$result"
}

# Dibujar linea con contenido
draw_content_line() {
    local content="$1"
    local padded=$(pad_right "$content")
    echo "${BOX_V} ${padded} ${BOX_V}"
}

# Dibujar linea vacia
draw_empty_line() {
    draw_content_line ""
}

# Dibujar header
draw_header() {
    local dry_run_status="$1"

    draw_top_border
    draw_empty_line
    draw_content_line "$(center_text "🍎 MacPrepare Setup Script")"
    draw_content_line "$(center_text "Configura tu Mac como te gusta")"
    draw_empty_line
    draw_separator

    local dry_text
    if [ "$dry_run_status" = "true" ]; then
        dry_text="${GREEN}ON${RESET}"
    else
        dry_text="${RED}OFF${RESET}"
    fi

    # Header de controles (sin colores para el calculo de padding)
    local controls="[a] Todo   [n] Nada   [d] Dry-run: ${dry_text}   [q] Salir"
    echo -e "${BOX_V} $(center_text "[a] Todo   [n] Nada   [d] Dry-run: ")${dry_text}$(center_text "   [q] Salir" 10) ${BOX_V}"
}

# Dibujar seccion
draw_section() {
    local icon="$1"
    local title="$2"
    draw_empty_line
    draw_content_line "${BOLD}${icon}  ${title}${RESET}"
}

# Dibujar opcion
draw_option() {
    local selected="$1"
    local current="$2"
    local label="$3"
    local note="${4:-}"

    local checkbox
    if [ "$selected" = "true" ]; then
        checkbox="${GREEN}[x]${RESET}"
    else
        checkbox="${GRAY}[ ]${RESET}"
    fi

    local prefix=""
    if [ "$current" = "true" ]; then
        prefix="${CYAN}>${RESET}"
    else
        prefix=" "
    fi

    local full_label="$label"
    if [ -n "$note" ]; then
        full_label="$label ${DIM}${note}${RESET}"
    fi

    echo -e "${BOX_V} ${prefix} ${checkbox} ${full_label}$(printf '%*s' $((WIDTH - ${#label} - ${#note} - 10)) '')${BOX_V}"
}

# Dibujar footer
draw_footer() {
    draw_empty_line
    draw_separator
    draw_content_line "$(center_text "[Enter] Ejecutar seleccionados")"
    draw_bottom_border
}

# Dibujar barra de progreso
draw_progress_bar() {
    local current=$1
    local total=$2
    local message="$3"
    local bar_width=30
    local filled=$((current * bar_width / total))
    local empty=$((bar_width - filled))

    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done

    echo -e "${BOX_V} [${GREEN}${bar}${RESET}] ${current}/${total} ${message}"
}

# Leer tecla (incluyendo flechas)
read_key() {
    local key
    read -rsk1 key

    # Si es escape, leer secuencia
    if [[ "$key" == $'\x1b' ]]; then
        read -rsk2 -t 0.1 key
        case "$key" in
            '[A') echo "UP" ;;
            '[B') echo "DOWN" ;;
            '[C') echo "RIGHT" ;;
            '[D') echo "LEFT" ;;
            *) echo "ESC" ;;
        esac
    elif [[ "$key" == "" ]]; then
        echo "ENTER"
    elif [[ "$key" == " " ]]; then
        echo "SPACE"
    else
        echo "$key"
    fi
}

# Mensaje de estado
print_status() {
    local type="$1"
    local message="$2"

    case "$type" in
        "success") echo -e "${GREEN}✓${RESET} $message" ;;
        "error")   echo -e "${RED}✗${RESET} $message" ;;
        "warning") echo -e "${YELLOW}!${RESET} $message" ;;
        "info")    echo -e "${BLUE}ℹ${RESET} $message" ;;
        "skip")    echo -e "${GRAY}○${RESET} $message" ;;
        "progress") echo -e "${YELLOW}►${RESET} $message" ;;
    esac
}

# Confirmar accion
confirm() {
    local message="$1"
    echo -e "${YELLOW}?${RESET} $message [s/N] "
    read -rsk1 response
    [[ "$response" =~ ^[sS]$ ]]
}
