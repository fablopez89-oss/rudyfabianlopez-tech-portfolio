$services = Get-Content ".\services_list.txt"

foreach ($svc in $services) {
    $state = Get-Service $svc -ErrorAction SilentlyContinue
    if ($state) {
        Write-Output "$svc -> $($state.Status)"
    } else {
        Write-Output "$svc no existe"
    }
}
