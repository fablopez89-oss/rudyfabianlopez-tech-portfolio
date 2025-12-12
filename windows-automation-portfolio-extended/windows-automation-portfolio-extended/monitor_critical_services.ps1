$CriticalServices = @("Dnscache", "W32Time", "Spooler")
foreach ($svc in $CriticalServices) {
    $info = Get-Service $svc -ErrorAction SilentlyContinue
    if ($info.Status -ne "Running") {
        Write-Warning "$svc no está ejecutándose"
    }
}
