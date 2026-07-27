#!/bin/bash
# modules/system/terminal.sh - Enable Touch ID for sudo

configure_touchid_sudo() {
    echo "  Configuring Touch ID for sudo..."

    local pam_file="/etc/pam.d/sudo_local"
    local pam_line="auth       sufficient     pam_tid.so"

    # Check if already configured
    if [ -f "$pam_file" ] && grep -q "pam_tid.so" "$pam_file"; then
        echo "  Touch ID for sudo is already configured"
        return 0
    fi

    # Create sudo_local if missing (recommended method on macOS Sonoma+)
    if [ ! -f "$pam_file" ]; then
        echo "  Creating Touch ID sudo configuration..."
        printf '%s\n' "# sudo_local: local sudo configuration file" "# Enable Touch ID for sudo authentication" "$pam_line" | tee "$pam_file" > /dev/null || return 1
    else
        # Append the line if the file exists but lacks the configuration
        echo "$pam_line" | tee -a "$pam_file" > /dev/null || return 1
    fi

    echo "  Touch ID enabled for sudo"
    echo "  Note: Works with physical Touch ID and Apple Watch"

    return 0
}

configure_touchid_sudo
