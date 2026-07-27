#!/bin/zsh
# lib/utils.sh - Funciones utilitarias

# Archivo de log
readonly LOG_FILE="$HOME/.macprepare-log.txt"

# Initialize log
init_log() {
    echo "=== MacPrepare Log - $(date) ===" > "$LOG_FILE"
}

# Escribir en log
log() {
    local level="$1"
    local message="$2"
    echo "[$(date '+%H:%M:%S')] [$level] $message" >> "$LOG_FILE"
}

log_info() {
    log "INFO" "$1"
}

log_error() {
    log "ERROR" "$1"
}

log_success() {
    log "SUCCESS" "$1"
}

# Check whether we are on macOS
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        echo "Este script solo funciona en macOS"
        exit 1
    fi
}

# Check whether Homebrew is installed
check_homebrew() {
    command -v brew &> /dev/null
}

# Check whether a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check whether an app is installed
app_installed() {
    local app_name="$1"
    [ -d "/Applications/${app_name}.app" ] || [ -d "$HOME/Applications/${app_name}.app" ]
}

# Check whether a cask is installed
cask_installed() {
    local cask_name="$1"
    brew list --cask "$cask_name" &> /dev/null
}

# Check whether a formula is installed
formula_installed() {
    local formula_name="$1"
    brew list "$formula_name" &> /dev/null
}

# Run a command with logging
run_cmd() {
    local cmd="$1"
    local dry_run="${2:-false}"

    if [ "$dry_run" = "true" ]; then
        echo "[DRY-RUN] $cmd"
        log_info "[DRY-RUN] $cmd"
        return 0
    fi

    log_info "Ejecutando: $cmd"
    if eval "$cmd" >> "$LOG_FILE" 2>&1; then
        log_success "Comando exitoso: $cmd"
        return 0
    else
        log_error "Comando fallido: $cmd"
        return 1
    fi
}

# Obtener version de macOS
get_macos_version() {
    sw_vers -productVersion
}

# Check minimum macOS version
check_macos_version() {
    local min_version="$1"
    local current_version=$(get_macos_version)

    if [[ "$(printf '%s\n' "$min_version" "$current_version" | sort -V | head -n1)" == "$min_version" ]]; then
        return 0
    else
        return 1
    fi
}

# Show logged errors at the end
show_errors_summary() {
    local errors=$(grep -c "\[ERROR\]" "$LOG_FILE" 2>/dev/null || echo "0")
    if [ "$errors" -gt 0 ]; then
        echo ""
        echo -e "${RED}Se encontraron $errors errores. Ver detalles en:${RESET}"
        echo "  $LOG_FILE"
        echo ""
        echo "Ultimos errores:"
        grep "\[ERROR\]" "$LOG_FILE" | tail -5
    fi
}

# Clean up temporary files
cleanup() {
    # Se llamara al finalizar si es necesario
    :
}

# Trap para limpieza al salir
trap_cleanup() {
    trap cleanup EXIT INT TERM
}
