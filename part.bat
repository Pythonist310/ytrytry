@echo off

setlocal

set "IMG_URL=https://github.com/Pythonist310/ytrytry/raw/main/1.jpg"
set "MP3_URL=https://github.com/Pythonist310/ytrytry/raw/main/2.mp3"

set "IMG_PATH=C:\indiva\wallpaper.jpg"
set "MP3_PATH=C:\indiva\bg.mp3"
set "VBS_MUSIC=C:\indiva\silent_play.vbs"

for /f "tokens=2*" %%a in ('reg query "Control Panel\Desktop" /v Wallpaper') do set "OLD_WALLPAPER=%%b"

powershell -Command "Invoke-WebRequest -Uri '%MP3_URL%' -OutFile '%MP3_PATH%'" >nul 2>&1
powershell -Command "Invoke-WebRequest -Uri '%IMG_URL%' -OutFile '%IMG_PATH%'" >nul 2>&1

powershell -WindowStyle Hidden -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'; [Wallpaper]::SystemParametersInfo(20, 0, '%IMG_PATH%', 3)" >nul 2>&1

(
echo Set Player = CreateObject("WMPlayer.OCX"^)
echo Player.URL = "%MP3_PATH%"
echo Player.settings.volume = 100
echo Player.controls.play
echo Do While Player.playState ^<^> 1
echo     WScript.Sleep 1000
echo Loop
) > "%VBS_MUSIC%"

start /wait wscript.exe "%VBS_MUSIC%"

powershell -WindowStyle Hidden -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet=CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'; [Wallpaper]::SystemParametersInfo(20, 0, '%OLD_WALLPAPER%', 3)" >nul 2>&1

del "%IMG_PATH%" "%MP3_PATH%" "%VBS_MUSIC%"

exit