Connect-MgGraph -Scopes Directory.Read.All
Get-MgUser | Select DisplayName,UserPrincipalName,AccountEnabled | Export-Csv "azure_ad_users.csv" -NoTypeInformation
