Import-Module ActiveDirectory

$users = Import-Csv ".\bulk_users.csv"

foreach ($u in $users) {
    New-ADUser -Name $u.Name -SamAccountName $u.Sam         -UserPrincipalName $u.Mail -GivenName $u.Given -Surname $u.Last         -AccountPassword (ConvertTo-SecureString $u.Password -AsPlainText -Force)         -Enabled $true
}
