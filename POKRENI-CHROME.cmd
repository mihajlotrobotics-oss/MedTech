@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0pokreni.ps1" -Browser Chrome
if errorlevel 1 pause
