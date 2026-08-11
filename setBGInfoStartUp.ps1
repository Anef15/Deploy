$STARTUP = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

# Créer le dossier s'il n'existe pas
if (-not (Test-Path $STARTUP)) {
    New-Item -ItemType Directory -Path $STARTUP -Force | Out-Null
}

$BAT = "$STARTUP\bginfo_startup.bat"

# Créer le fichier batch avec le contenu
@"
@echo off
cd /d "C:\IT\Sync\BGInfo"
bginfo64.exe anef15.bgi /timer:0 /silent /accepteula
"@ | Set-Content -Path $BAT -Encoding ASCII
