clear-host
Import-Module ActiveDirectory
$a = "C:\Active_AD_Users.csv"
$list = Get-ADUser -Filter * -Properties DisplayName, Enabled, EmailAddress, SamAccountName, Department |`
select DisplayName, Enabled, EmailAddress, SamAccountName, Department 
$enabled = $list | where { $_.DisplayName -ne '' -and $_.Enabled -eq 'True' } 
$users = $enabled | where { $_.Displayname -match "\." -and $_.EmailAddress -match "\@" } | epcsv $a


