#######################################################################################
# Suppression du dossier Deploy-Main et de la variable TEMPPASS au démarrage,
# puis auto-suppression de la tâche planifiée
#######################################################################################

$taskName = "CleanupOnStartup"

# Commande exécutée par la tâche planifiée
$command = @'
try {
    Remove-Item -Path 'C:\IT\Deploy-Main' `
        -Recurse `
        -Force `
        -ErrorAction SilentlyContinue
}
catch {
    # Ignorer les erreurs de suppression du dossier
}

try {
    [Environment]::SetEnvironmentVariable(
        'TEMPPASS',
        $null,
        [EnvironmentVariableTarget]::Machine
    )
}
catch {
    # Ignorer les erreurs de suppression de la variable
}

Start-Sleep -Seconds 2

Unregister-ScheduledTask `
    -TaskName 'CleanupOnStartup' `
    -Confirm:$false `
    -ErrorAction SilentlyContinue
'@

# Encodage UTF-16LE requis par -EncodedCommand
$encodedCommand = [Convert]::ToBase64String(
    [System.Text.Encoding]::Unicode.GetBytes($command)
)

$trigger = New-ScheduledTaskTrigger -AtStartup

$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $encodedCommand"

$principal = New-ScheduledTaskPrincipal `
    -UserId "NT AUTHORITY\SYSTEM" `
    -LogonType ServiceAccount `
    -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable

Register-ScheduledTask `
    -TaskName $taskName `
    -Trigger $trigger `
    -Action $action `
    -Principal $principal `
    -Settings $settings `
    -Force |
    Out-Null
