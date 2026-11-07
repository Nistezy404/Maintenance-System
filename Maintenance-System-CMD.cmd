@echo off
setlocal
title Toolkit de Manutencao Windows
chcp 65001 >nul
echo Iniciando o Toolkit de Manutencao...
set "SCRIPT=%~dp0Toolkit-Manutencao-Windows.ps1"
if not exist "%SCRIPT%" (
    echo [ERRO] Nao encontrei Toolkit-Manutencao-Windows.ps1 nesta pasta.
    pause
    exit /b 1
)
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"
if errorlevel 1 (
    echo.
    echo O PowerShell retornou um erro. Consulte a mensagem acima.
    pause
)
endlocal
