﻿#start of function
function ManagementTrafficOn 
{
<#
.SYNOPSIS
    Enable vMotion
.DESCRIPTION
    Enable vMotion across the Cluster
.NOTES
    File Name      : ManagementTrafficOn.ps1
    Author         : gajendra d ambi
    Date           : Feb 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>
#start of script
$cluster  = Read-Host "name of the cluster[type * to include all clusters]?"
$pg       = Read-Host "name of the portgroup?"

$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer

Get-Cluster $cluster | Get-VMHost | Get-VMHostNetworkAdapter | where PortGroupname -EQ $pg | Set-VMHostNetworkAdapter -ManagementTrafficEnabled $false -Confirm:$false
$stopWatch.Stop()
Write-Host "Elapsed Runtime:" $stopWatch.Elapsed.Hours "Hours" $stopWatch.Elapsed.Minutes "minutes and" $stopWatch.Elapsed.Seconds "seconds." -BackgroundColor White -ForegroundColor Black
#End of Script#
}#End of function