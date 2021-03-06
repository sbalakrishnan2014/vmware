<#
.SYNOPSIS
    create DVS vmware esxi hosts.
.DESCRIPTION
    This will create DVS your vcenter
.NOTES
    File Name      : fun_create_dvs.ps1
    Author         : gajendra d ambi
    Date           : January 2016
    recommended    : PowerShell v4+, powercli 6+ over win7 and upper.
    Copyright      - None
.LINK
    Script posted over: github.com/gajuambi/vmware   
#>

#start of script
#start of function
Function fun_create_vds {
$dc       = Read-Host "Name of the datacenter?:"
$dvs      = Read-Host "Name of the vSphere Distributed Switch(vDS)?:"
$NumPorts = Read-Host "Number of uplinkports?:"
$mtu      = Read-Host "mtu?"
New-VDSwitch -Name $dvs -Mtu $mtu -Location $dc -NumUplinkPorts $NumPorts -Confirm:$false
}
#End of Function
fun_create_vds
#End of Script
