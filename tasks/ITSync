######################################################################################################################
# Ce script crée deux taches.
# 1 = tache de permettant la synchronisation au démarrage du GIT dans le dossier IT\Sync
# 2 = tache lance start.ps1 depuis le dossier sync. Ce script permet d'intervenir à distance sur l'ensemble des posts.
######################################################################################################################
$taskName = "ITSync"
$scriptPath = "C:\IT\Scripts\IT_Sync.ps1"

# Commande qui exécute le script PS1
$command = "-ExecutionPolicy Bypass -Command `"& '$scriptPath'`""

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


######################################
$taskName = "ITSyncStartScript"
$scriptPath = "C:\IT\Sync\start.ps1"
######################################
# Commande qui exécute le script PS1
$command = "-ExecutionPolicy Bypass -Command `"& '$scriptPath'`""

$trigger = New-ScheduledTaskTrigger -AtStartup -Delay (New-TimeSpan -Minutes 3)
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
