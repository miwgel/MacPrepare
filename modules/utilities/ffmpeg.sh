#!/bin/bash
# modules/utilities/ffmpeg.sh - Instalar FFMPEG

install_ffmpeg() {
    echo "  Instalando FFMPEG..."

    if command_exists ffmpeg; then
        echo "  FFMPEG ya esta instalado: $(ffmpeg -version 2>&1 | head -1)"
        return 0
    fi

    brew install ffmpeg

    echo "  FFMPEG instalado: $(ffmpeg -version 2>&1 | head -1)"

    return 0
}

install_ffmpeg
