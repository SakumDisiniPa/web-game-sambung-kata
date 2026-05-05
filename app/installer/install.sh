#!/bin/bash

# Sambung Kata Installer for Linux
echo "======================================"
echo "Installing Sambung Kata..."
echo "======================================"

# Configuration
ZIP_URL="https://github.com/SakumDisiniPa/game-sambung-kata/releases/download/V1.6.4/bundle.zip"
ICON_URL="https://sambungkata.sakum.my.id/app/iconapp/icon.png"
INSTALL_DIR="$HOME/sambung_kata"
APP_NAME="Sambung Kata"

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    echo "Peringatan: Sambung Kata sudah terinstall di $INSTALL_DIR"
    read -p "Apakah Anda ingin menghapus versi lama dan menginstall ulang? (y/n): " choice < /dev/tty
    case "$choice" in 
      y|Y ) echo "Menghapus versi lama..."; rm -rf "$INSTALL_DIR";;
      * ) echo "Instalasi dibatalkan."; exit 0;;
    esac
fi

# Create installation directory
echo "Creating installation directory at $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

# Download Icon
echo "Downloading icon..."
curl -L -s "$ICON_URL" -o "icon.png"

# Download Bundle
echo "Downloading game files (this may take a while)..."
curl -L "$ZIP_URL" -o "bundle.zip"

# Unzip
echo "Extracting files..."
if command -v unzip >/dev/null; then
    unzip -o "bundle.zip"
else
    echo "Error: 'unzip' is not installed. Please install it first (sudo apt install unzip)."
    exit 1
fi
rm "bundle.zip"

# Make binaries executable
echo "Setting permissions..."
chmod +x -R .

# Create Desktop Entry
echo "Creating desktop shortcut..."
DESKTOP_FILE="$HOME/.local/share/applications/sambungkata.desktop"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=$APP_NAME
Exec=$INSTALL_DIR/game_sambung_kata
Icon=$INSTALL_DIR/icon.png
Type=Application
Categories=Game;
Terminal=false
Comment=Game Sambung Kata Multiplayer
EOF

chmod +x "$DESKTOP_FILE"

echo "======================================"
echo "Installation complete!"
echo "You can find $APP_NAME in your apps menu."
echo "======================================"
