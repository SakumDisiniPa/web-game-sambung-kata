@echo off
setlocal
title Sambung Kata Installer

echo ======================================
echo Installing Sambung Kata for Windows...
echo ======================================

set "ZIP_URL=https://github.com/SakumDisiniPa/web-game-sambung-kata/releases/download/v1.6.4/game-sambung-kata-windows.zip"
set "ICON_URL=https://sambungkata.sakum.my.id/app/iconapp/icon.png"
set "INSTALL_DIR=%USERPROFILE%\sambung_kata"
set "APP_NAME=Sambung Kata"

:: Check if already installed
if exist "%INSTALL_DIR%" (
    echo Peringatan: Sambung Kata sudah terinstall di %INSTALL_DIR%
    set /p choice="Apakah Anda ingin menghapus versi lama dan menginstall ulang? (y/n): "
    if /i not "%choice%"=="y" (
        echo Instalasi dibatalkan.
        pause
        exit /b 0
    )
    echo Menghapus versi lama...
    rd /s /q "%INSTALL_DIR%"
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

echo Downloading icon...
powershell -Command "Invoke-WebRequest -Uri '%ICON_URL%' -OutFile 'icon.png'"

echo Downloading game files...
powershell -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile 'game-sambung-kata-windows.zip'"

echo Extracting files...
powershell -Command "Expand-Archive -Path 'game-sambung-kata-windows.zip' -DestinationPath '.' -Force"
del game-sambung-kata-windows.zip

echo Creating Desktop Shortcut...
set "SHORTCUT_PATH=%USERPROFILE%\Desktop\%APP_NAME%.lnk"
set "EXE_PATH=%INSTALL_DIR%\game_sambung_kata.exe"

powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT_PATH%');$s.TargetPath='%EXE_PATH%';$s.WorkingDirectory='%INSTALL_DIR%';$s.IconLocation='%INSTALL_DIR%\icon.png';$s.Save()"

echo ======================================
echo Installation complete!
echo Shortcut created on your Desktop.
echo ======================================
pause
