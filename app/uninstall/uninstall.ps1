# Sambung Kata Uninstaller for Windows (PowerShell Version)
$ErrorActionPreference = "Stop"

Write-Host "======================================" -ForegroundColor Yellow
Write-Host "Uninstalling Sambung Kata..." -ForegroundColor Yellow
Write-Host "======================================" -ForegroundColor Yellow

$INSTALL_DIR = "$HOME\sambung_kata"
$APP_NAME = "Sambung Kata"
$ShortcutPath = "$HOME\Desktop\$APP_NAME.lnk"

$choice = Read-Host "Apakah Anda yakin ingin menghapus $APP_NAME? (y/n)"
if ($choice -ne "y") {
    Write-Host "Uninstall dibatalkan."
    return
}

Write-Host "Menghapus file aplikasi..."
if (Test-Path $INSTALL_DIR) {
    Remove-Item -Path $INSTALL_DIR -Recurse -Force
}

Write-Host "Menghapus shortcut..."
if (Test-Path $ShortcutPath) {
    Remove-Item -Path $ShortcutPath -Force
}

Write-Host "======================================" -ForegroundColor Green
Write-Host "Uninstall berhasil!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
