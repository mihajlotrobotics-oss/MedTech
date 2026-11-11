@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0pokreni.ps1" -Browser Edge
if errorlevel 1 pause
