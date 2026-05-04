# Sambung Kata Installer for Windows (PowerShell Version)
$ErrorActionPreference = "Stop"

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Installing Sambung Kata..." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

$BASE_URL = "https://sambungkata.sakum.my.id"
$ZIP_URL = "$BASE_URL/app/windows/bundle.zip"
$ICON_URL = "$BASE_URL/app/iconapp/icon.png"
$INSTALL_DIR = "$HOME\sambung_kata"
$APP_NAME = "Sambung Kata"

# Check if already installed
if (Test-Path $INSTALL_DIR) {
    Write-Host "Peringatan: Sambung Kata sudah terinstall di $INSTALL_DIR" -ForegroundColor Yellow
    $choice = Read-Host "Apakah Anda ingin menghapus versi lama dan menginstall ulang? (y/n)"
    if ($choice -ne "y") {
        Write-Host "Instalasi dibatalkan."
        return
    }
    Write-Host "Menghapus versi lama..."
    Remove-Item -Path $INSTALL_DIR -Recurse -Force
}

# Create installation directory
New-Item -Path $INSTALL_DIR -ItemType Directory -Force | Out-Null
Set-Location -Path $INSTALL_DIR

Write-Host "Downloading icon..."
Invoke-WebRequest -Uri $ICON_URL -OutFile "icon.png"

Write-Host "Downloading game files..."
Invoke-WebRequest -Uri $ZIP_URL -OutFile "bundle.zip"

Write-Host "Extracting files..."
Expand-Archive -Path "bundle.zip" -DestinationPath "." -Force
Remove-Item -Path "bundle.zip"

Write-Host "Creating Desktop Shortcut..."
$ShortcutPath = "$HOME\Desktop\$APP_NAME.lnk"
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "$INSTALL_DIR\bundle\sambung_kata.exe"
$Shortcut.WorkingDirectory = $INSTALL_DIR
$Shortcut.IconLocation = "$INSTALL_DIR\icon.png"
$Shortcut.Save()

Write-Host "======================================" -ForegroundColor Green
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Shortcut created on your Desktop." -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
