$processes = Get-Process
$processes | % {
$vmmp = & 'C:\Program Files (x86)\SysinternalsSuite\vmmap.exe' '-64' '-p' $_.id '>>' 'C:\Vmmap_Output.csv'
Start-Sleep -Seconds 3
}