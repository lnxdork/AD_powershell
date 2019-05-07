clear-host
Import-Module ActiveDirectory
$hash_lastLogonTimestamp = @{Name="LastLogonTimeStamp";Expression={([datetime]::FromFileTime($_.LastLogonTimeStamp))}}
$hash_lastLogon = @{Name="LastLogon";Expression={([datetime]::FromFileTime($_.LastLogon))}}
$hash_pwdLastSet = @{Name="pwdLastSet";Expression={([datetime]::FromFileTime($_.pwdLastSet))}}

get-aduser -filter * -properties SamAccountName, Employeeid, Name, Description, distinguishedName, lastLogon, lastLogonTimeStamp, accountExpires, createTimeStamp, pwdLastset |` 
select SamAccountName, Employeeid, Name, Description, distinguishedName, $hash_lastLogon, accountExpires, createTimeStamp, $hash_lastLogonTimestamp,$hash_pwdLastSet |`
export-csv C:/somefile.csv
