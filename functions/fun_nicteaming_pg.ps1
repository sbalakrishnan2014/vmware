<#
.SYNOPSIS
    update nicteaming on portgroup.
.DESCRIPTION
    this will update the NIC assigned for a portgroup
.NOTES
    File Name      : fun_nicteaming_pg.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#Start of script
#start of function
Function fun_nicteaming_vss {
$cluster = Read-Host "name of the cluster(hint:type * to include all clusters)"
$pg      = Read-Host "name of the portgroup(hint:type * to include all portgroups)"

$a       = (get-virtualportgroup -Name $pg).ExtensionData.ComputedPolicy.NicTeaming.NicOrder.ActiveNic
$b       = (get-virtualportgroup -Name $pg).ExtensionData.ComputedPolicy.NicTeaming.NicOrder.StandbyNic
$vmnics  = ($a + $b) | sort
$vmnic0  = $vmnics[0]
$vmnic1  = $vmnics[1]

Write-Host "
            1 - $vmnic0 active  $vmnic1 standby
            2 - $vmnic0 standby $vmnic1 active
            3 - $vmnic0 unused  $vmnic1 active
            4 - $vmnic1 active  $vmnic0 standby
            5 - $vmnic1 standby $vmnic0 active
            6 - $vmnic1 unused  $vmnic0 active"
write-host "7 - $vmnic0 active  $vmnic1 active" -ForegroundColor Yellow

$option = Read-Host "choose your option:"

   foreach ($vmhost in (get-cluster $cluster | get-vmhost)) { 
    if ($option -eq "1") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive  $vmnic0 -MakeNicStandby $vmnic1 -Confirm:$false}
    if ($option -eq "2") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $vmnic0 -MakeNicActive  $vmnic1 -Confirm:$false}
    if ($option -eq "3") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused  $vmnic0 -MakeNicActive  $vmnic1 -Confirm:$false}
    if ($option -eq "4") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive  $vmnic0 -MakeNicStandby $vmnic1 -Confirm:$false}
    if ($option -eq "5") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicStandby $vmnic0 -MakeNicActive  $vmnic1 -Confirm:$false}
    if ($option -eq "6") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicUnused  $vmnic0 -MakeNicActive  $vmnic1 -Confirm:$false}
    if ($option -eq "7") {Get-VMHost $vmhost | Get-Virtualportgroup -Name $pg | Get-NicTeamingPolicy | Set-NicTeamingPolicy -MakeNicActive  $vmnic0 -MakeNicActive  $vmnic1 -Confirm:$false}
  }
}

#End of function
fun_nicteaming_vss
#End of Script
