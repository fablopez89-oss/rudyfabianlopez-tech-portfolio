Connect-AzAccount
$vms = Get-AzVM

foreach ($vm in $vms) {
    $status = Get-AzVM -ResourceGroup $vm.ResourceGroupName -Name $vm.Name -Status
    Write-Output "$($vm.Name) -> $($status.Statuses[1].DisplayStatus)"
}
