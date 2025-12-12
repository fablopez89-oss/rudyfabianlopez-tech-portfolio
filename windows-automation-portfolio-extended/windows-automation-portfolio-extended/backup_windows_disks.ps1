$source = "C:\Data"
$dest = "D:\Backups\DataBackup"

if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest }

robocopy $source $dest /MIR /R:2 /W:2 /LOG:backup_log.txt
