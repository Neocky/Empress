<#
.SYNOPSIS
Checks if the specific script is running as administrator

.DESCRIPTION
This script will check if the command is running in an elevated console.
#>
function checkRunAsAdmin {
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "Command needs to be run as administrator! Creating UAC prompt"
        Write-Host "                                    3"
        Start-Sleep -Seconds 1
        Write-Host "                                    2"
        Start-Sleep -Seconds 1
        Write-Host "                                    1"
        Start-Sleep -Seconds 1
        Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs -WindowStyle Hidden
        #Break
    }
}
