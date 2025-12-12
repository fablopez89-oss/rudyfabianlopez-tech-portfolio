$cpu = Get-Counter '\Processor(_Total)\% Processor Time'
$ram = Get-Counter '\Memory\Available MBytes'
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | 
        Select DeviceID,Size,FreeSpace

Write-Output "CPU: $($cpu.CounterSamples.CookedValue)"
Write-Output "RAM libre MB: $($ram.CounterSamples.CookedValue)"
Write-Output "Discos:"
$disk | Format-Table -AutoSize
