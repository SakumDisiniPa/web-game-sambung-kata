@echo off
setlocal
title Sambung Kata Uninstaller

echo ======================================
echo Uninstalling Sambung Kata for Windows...
echo ======================================

set "INSTALL_DIR=%USERPROFILE%\sambung_kata"
set "APP_NAME=Sambung Kata"
set "SHORTCUT_PATH=%USERPROFILE%\Desktop\%APP_NAME%.lnk"

set /p confirm="Apakah Anda yakin ingin menghapus %APP_NAME%? (y/n): "
if /i not "%confirm%"=="y" (
    echo Uninstall dibatalkan.
    pause
    exit /b 0
)

echo Menghapus file aplikasi...
if exist "%INSTALL_DIR%" (
    rd /s /q "%INSTALL_DIR%"
) else (
    echo Direktori instalasi tidak ditemukan.
)

echo Menghapus shortcut...
if exist "%SHORTCUT_PATH%" (
    del "%SHORTCUT_PATH%"
)

echo ======================================
echo Uninstall berhasil!
echo ======================================
pause
