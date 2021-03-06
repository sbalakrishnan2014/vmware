<#
.SYNOPSIS
   This will remove the  portgroup
.DESCRIPTION
   This should delete both types of portgroups, the VM portgroup and the vmkernel portgroup.
.NOTES
    File Name      : fun_remove_pg.ps1
    Author         : gajendra d ambi
    Date           : December 2015 
    Prerequisites  : PowerShell V4, powercli 5+ over Vista and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#start of script
#start of function
Function fun_remove_pg {
 #variables
 $cluster = Read-Host "name of the cluster(hint:type * to include all cluster)"
 $pg      = read-host "name of the portgroup?"
 
foreach ($vmhost in (get-cluster $cluster | get-vmhost | sort)) {
 $vmk = Get-VMHostNetworkAdapter -VMHost $vmhost | where PortgroupName -eq $pg
  if ($vmk -ne $null) {
  Remove-VMHostNetworkAdapter -Nic $vmk -confirm:$false
  }
  get-vmhost $vmhost | get-virtualportgroup -Name $pg | Remove-VirtualPortGroup -Confirm:$false
 }
}
#end of function
fun_remove_pg
#end of script
