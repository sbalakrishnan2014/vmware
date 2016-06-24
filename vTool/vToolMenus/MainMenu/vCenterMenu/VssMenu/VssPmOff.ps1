﻿
#start of function
Function VssPmOff
{
<#
.SYNOPSIS
    Allow promiscous mode
.DESCRIPTION
    This will allow promiscous mode on a vswitch.
.NOTES
    File Name      : VssPmOff.ps1
    Author         : gajendra d ambi
    Date           : March 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>
#Start of Script
$cluster = Read-Host "name of the cluster[type * to include all clusters]?"
$vss     = Read-Host "Name of the vSwitch?"

$TimeStart = Get-Date #start time
$TimeEnd   = Get-Date #end time
$TimeTaken = $TimeEnd - $TimeStart #total time taken
$TimeStart #starting the timer

Get-cluster $cluster | Get-VMHost | Get-VirtualSwitch -Name $vss | Get-SecurityPolicy | Set-SecurityPolicy -AllowPromiscuous $false -Confirm:$false

$TimeEnd #stopping the timer
Write-Host "Time taken - $TimeTaken" -BackgroundColor White -ForegroundColor blue #total time taken
 #End of Script#
}#End of function