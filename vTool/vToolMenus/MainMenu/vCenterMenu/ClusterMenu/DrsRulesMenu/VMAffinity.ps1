﻿
#start of function
Function VMAffinity 
{
<#
.SYNOPSIS
    Create VMAffinity DRS Rule.
.DESCRIPTION
    This uses custom functions to create DRS VMAffinity rules between VMs where VMs will be made to stay on the same host by the DRS.
.NOTES
    File Name      : VMAffinity.ps1
    Author         : gajendra d ambi
    Date           : February 2016
    Prerequisite   : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware
#>

#Start of Script
$cluster = Read-Host "Name of the Cluster?"
$drsrule = Read-Host "Type the Name of the DRS Rule"
$vms     = Read-Host "Name of the VMs (separated by comma, no space)?"
$vms     = $vms.split(',')
New-DrsRule –Name $drsrule -Cluster $cluster –KeepTogether $true –VM $vms
#End of Script
}#End of function
