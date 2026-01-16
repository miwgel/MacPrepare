#!/bin/bash
# modules/utilities/yt-dlp.sh - Instalar yt-dlp

install_ytdlp() {
    echo "  Instalando yt-dlp..."

    if command -v yt-dlp &> /dev/null; then
        echo "  yt-dlp ya esta instalado"
        return 0
    fi

    brew install yt-dlp

    echo "  yt-dlp instalado"

    return 0
}

install_ytdlp
