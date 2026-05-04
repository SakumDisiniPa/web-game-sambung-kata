#!/bin/bash

# Sambung Kata Uninstaller for Linux
echo "======================================"
echo "Uninstalling Sambung Kata..."
echo "======================================"

INSTALL_DIR="$HOME/sambung_kata"
DESKTOP_FILE="$HOME/.local/share/applications/sambungkata.desktop"

read -p "Apakah Anda yakin ingin menghapus Sambung Kata? (y/n): " confirm
if [[ $confirm == [yY] ]]; then
    echo "Menghapus file aplikasi..."
    rm -rf "$INSTALL_DIR"
    
    echo "Menghapus shortcut..."
    rm -f "$DESKTOP_FILE"
    
    echo "======================================"
    echo "Uninstall berhasil!"
    echo "======================================"
else
    echo "Uninstall dibatalkan."
fi
