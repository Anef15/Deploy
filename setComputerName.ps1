$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

$newName = "$env:COMPUTERID"

if ([string]::IsNullOrWhitespace($newName)) {
    throw "No computer name was provided."
}

$keys = @(
    @{ LiteralPath = 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName'; Name = 'ComputerName' },
    @{ LiteralPath = 'Registry::HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'; Name = 'Hostname' },
    @{ LiteralPath = 'Registry::HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'; Name = 'NV Hostname' }
)

foreach ($key in $keys) {
    Set-ItemProperty @key -Type 'String' -Value $newName
}
