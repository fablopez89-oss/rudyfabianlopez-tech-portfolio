Connect-MgGraph -Scopes RoleManagement.Read.All

Get-MgRoleManagementDirectoryRoleAssignment | 
    Select RoleDefinitionId, PrincipalId, DirectoryScopeId | 
    Export-Csv "m365_role_assignments.csv" -NoTypeInformation
