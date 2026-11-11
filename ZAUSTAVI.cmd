@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0zaustavi.ps1"
if errorlevel 1 pause
