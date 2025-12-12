Get-LocalGroupMember -Group "Administrators" | 
    Select Name, ObjectClass | 
    Export-Csv "local_admins_report.csv" -NoTypeInformation
