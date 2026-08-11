@echo off
set "STARTUP=%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%STARTUP%" mkdir "%STARTUP%"
set "BAT=%STARTUP%\bginfo_startup.bat"(
  echo @echo off
  echo cd /d "C:\IT\Sync\BGInfo"
  echo bginfo64.exe anef15.bgi /timer:0 /silent /accepteula
) > "%BAT%"
