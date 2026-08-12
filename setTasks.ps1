$dossier = "C:\IT\Deploy-main\tasks"

foreach ($script in Get-ChildItem -Path $dossier -Filter "*.ps1" -File) {
    & powershell.exe -ExecutionPolicy Bypass -File $script.FullName
}
