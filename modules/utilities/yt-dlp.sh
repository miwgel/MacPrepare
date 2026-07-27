#!/bin/bash
# modules/utilities/yt-dlp.sh - Install yt-dlp

install_ytdlp() {
    echo "  Installing yt-dlp..."

    if command -v yt-dlp &> /dev/null; then
        echo "  yt-dlp is already installed"
        return 0
    fi

    brew install yt-dlp || return 1
    echo "  yt-dlp installed"

    return 0
}

install_ytdlp
