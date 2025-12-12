$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Scripts\script.ps1"
$Trigger = New-ScheduledTaskTrigger -Daily -At 3am
Register-ScheduledTask -TaskName "AutomatedScriptTask" -Action $Action -Trigger $Trigger -RunLevel Highest
