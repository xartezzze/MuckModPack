@echo off
title Muck Mod Kurulumu
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0kur.ps1" %*
echo.
pause
