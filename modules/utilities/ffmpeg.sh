#!/bin/bash
# modules/utilities/ffmpeg.sh - Install FFMPEG

install_ffmpeg() {
    echo "  Installing FFMPEG..."

    if command_exists ffmpeg; then
        echo "  FFMPEG is already installed: $(ffmpeg -version 2>&1 | head -1)"
        return 0
    fi

    brew install ffmpeg || return 1
    echo "  FFmpeg installed: $(ffmpeg -version 2>&1 | head -1)"

    return 0
}

install_ffmpeg
