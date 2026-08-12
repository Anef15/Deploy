$AccountName = "Bg_4n3f"
$PlainPassword = "%TEMPPASS%"
$securePwd = ConvertTo-SecureString -String $PlainPassword -AsPlainText -Force

# Crée le compte (échoue si existe déjà)
New-LocalUser -Name $AccountName -Password $securePwd -FullName $AccountName -Description "" -AccountNeverExpires

# Ajoute au groupe Administrateurs
Add-LocalGroupMember -Group "Administrateurs" -Member $AccountName
