Connect-MgGraph -Scopes User.ReadWrite.All
Select-MgProfile beta

$users = Import-Csv ".\bulk_users.csv"

foreach ($u in $users) {
    New-MgUser -AccountEnabled $true         -DisplayName $u.Display         -UserPrincipalName $u.UPN         -MailNickname $u.Nick         -PasswordProfile @{ Password=$u.Pass; ForceChangePasswordNextSignIn=$true }
}
