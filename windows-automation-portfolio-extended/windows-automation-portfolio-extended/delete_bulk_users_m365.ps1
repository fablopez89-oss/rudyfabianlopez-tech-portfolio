Connect-MgGraph -Scopes User.ReadWrite.All
Select-MgProfile beta

$users = Import-Csv ".\users_to_delete.csv"

foreach ($u in $users) {
    $upn = $u.UPN
    $user = Get-MgUser -Filter "userPrincipalName eq '$upn'"

    if ($user) {
        Remove-MgUser -UserId $user.Id -Confirm:$false
        Write-Output "Eliminado (Soft-Delete): $upn"
    } else {
        Write-Output "No encontrado: $upn"
    }
}
