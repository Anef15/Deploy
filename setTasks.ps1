$dossier = "C:\Chemin\Dossier"
foreach ($script in Get-ChildItem $dossier -Filter "*.ps1" -File) {
    & $script.FullPath
}
