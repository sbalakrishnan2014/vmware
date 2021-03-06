<#
.SYNOPSIS
    add hosts to distributed vistual switch.
.DESCRIPTION
    This will create distributed portgroup for your DVS
.NOTES
    File Name      : fun_addhosts_dvs.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_addhosts_dvs {
$csv = "$PSScriptRoot/addhosts.csv"
if ($csv -ne $null){Remove-Item $csv -Force}
$csv >> "$PSScriptRoot/addhosts.csv"
$csv = "$PSScriptRoot/addhosts.csv"
$csv | select dvs, hosts | Export-Csv $csv

Write-Host "update the csv file with a text editor,save & close it & then hit enter" -ForegroundColor Yellow

start-process $csv
Read-Host "Hit Enter/Return to continue"
$csv = import-csv $csv
$csv

$cluster = Read-Host "name of the cluster?(type * to include all clusters)"
$nic1    = Read-Host "type the name of the network adapter to add(ex:vmnic2)"
$nic2    = Read-Host "type the name of another network adapter to add(ex:vmnic3)"

 foreach ($line in $csv){
 $dvs    = $($line.dvs)
 $vmhost = $($line.hosts)
 Add-VDSwitchVMHost -VDSwitch $dvs -VMHost (get-cluster $cluster | get-vmhost $vmhost) -confirm:$false

 $pnic = Get-VMHostNetworkAdapter -VMHost $vmhost -Physical -Name $nic1
 Get-VDSwitch $dvs | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $pnic -confirm:$false
 $pnic = Get-VMHostNetworkAdapter -VMHost $vmhost -Physical -Name $nic2
 Get-VDSwitch $dvs | Add-VDSwitchPhysicalNetworkAdapter -VMHostNetworkAdapter $pnic -confirm:$false
 }
}
#End of function
fun_addhosts_dvs
#End of script
