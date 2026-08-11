$dossier = "C:\IT\Deploy-main\tasks"
foreach ($script in Get-ChildItem $dossier -Filter "*.ps1" -File) {
    & $script.FullPath
}
