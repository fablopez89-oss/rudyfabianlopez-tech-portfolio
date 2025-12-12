Connect-MgGraph -Scopes User.ReadWrite.All

$users = Import-Csv ".\m365_licenses.csv"
$sku = "ENTERPRISEPACK"

foreach ($u in $users) {
    $user = Get-MgUser -Filter "userPrincipalName eq '$($u.UPN)'"
    Set-MgUserLicense -UserId $user.Id -AddLicenses @{SkuId=$sku} -RemoveLicenses @()
}
