Import-Module ActiveDirectory

$users = Import-Csv ".\users_to_delete.csv"

foreach ($u in $users) {
    $sam = $u.SamAccountName
    $user = Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue

    if ($user) {
        Remove-ADUser -Identity $user -Confirm:$false
        Write-Output "Eliminado: $sam"
    } else {
        Write-Output "No encontrado: $sam"
    }
}
