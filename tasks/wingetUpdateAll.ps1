###########################################################################################
# tache permettant la mise à jour des logiciels automatique par winget à chaque démarrage.#
###########################################################################################
$taskName = "WingetUpdateAll"

# Commande qui exécute le script PS1
$command = "winget update --all --silent"

$trigger = New-ScheduledTaskTrigger -AtStartup
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $command
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable

Register-ScheduledTask -TaskName $taskName `
    -Trigger $trigger `
    -Action $action `
    -Principal $principal `
    -Settings $settings `
    -Force | Out-Null
