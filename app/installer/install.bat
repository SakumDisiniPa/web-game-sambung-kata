@echo off
setlocal
title Sambung Kata Installer

echo ======================================
echo Installing Sambung Kata for Windows...
echo ======================================

set "BASE_URL=https://sambungkata.sakum.my.id"
set "ZIP_URL=%BASE_URL%/app/windows/bundle.zip"
set "ICON_URL=%BASE_URL%/app/iconapp/icon.png"
set "INSTALL_DIR=%USERPROFILE%\sambung_kata"
set "APP_NAME=Sambung Kata"

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

echo Downloading icon...
powershell -Command "Invoke-WebRequest -Uri '%ICON_URL%' -OutFile 'icon.png'"

echo Downloading game files...
powershell -Command "Invoke-WebRequest -Uri '%ZIP_URL%' -OutFile 'bundle.zip'"

echo Extracting files...
powershell -Command "Expand-Archive -Path 'bundle.zip' -DestinationPath '.' -Force"
del bundle.zip

echo Creating Desktop Shortcut...
set "SHORTCUT_PATH=%USERPROFILE%\Desktop\%APP_NAME%.lnk"
set "EXE_PATH=%INSTALL_DIR%\bundle\sambung_kata.exe"

powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT_PATH%');$s.TargetPath='%EXE_PATH%';$s.WorkingDirectory='%INSTALL_DIR%';$s.IconLocation='%INSTALL_DIR%\icon.png';$s.Save()"

echo ======================================
echo Installation complete!
echo Shortcut created on your Desktop.
echo ======================================
pause
