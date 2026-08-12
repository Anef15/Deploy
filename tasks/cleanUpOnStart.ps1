###########################################################################################
# Tache permettant la suppression du dossier Deploy-Main et de la variable TEMPPASS     #
# au démarrage, puis s'auto-supprime.                                                    #
###########################################################################################

$taskName = "CleanupOnStartup"

# Commande qui exécute les suppressions et l'auto-suppression
$command = @"
Remove-Item -Path 'C:\IT\Deploy-Main' -Recurse -Force -ErrorAction SilentlyContinue;
[Environment]::SetEnvironmentVariable('TEMPPASS', `$null, 'Machine') -ErrorAction SilentlyContinue;
Unregister-ScheduledTask -TaskName 'CleanupOnStartup' -Confirm:`$false -ErrorAction SilentlyContinue
"@

$trigger = New-ScheduledTaskTrigger -AtStartup
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command $command"
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
