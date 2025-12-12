Connect-AzAccount
Get-AzResource | Export-Csv "azure_resources_report.csv" -NoTypeInformation
