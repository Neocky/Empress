<#
.SYNOPSIS
Executes the package uninstallation script. 

.DESCRIPTION
This script handles the execution of the package uninstallation script [empressuninstall.ps1] of the previously downloaded Empress Package.
#>

# Starts the empressuninstall.ps1 from the package
function startPackageUninstallScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$nameOfPackage,
        [Parameter(Mandatory=$true)][String]$pathToEmpUninstallScript
    )
    $validInstallScriptPath = Test-Path $pathToEmpUninstallScript
    if ($validInstallScriptPath -eq $true) {
        Write-Host "Execute Empress uninstallation script"
        Try {
            Start-Process powershell $pathToEmpUninstallScript -Verb RunAs -WindowStyle Hidden -Wait
            deleteUninstallationFolder -pathToUninstallScript $pathToEmpUninstallScript
            Write-Host "Succesfully uninstalled Empress package" -ForegroundColor Green
        } catch {
            Write-Warning "Package couldn't be uninstalled"
            Write-Host "Skip uninstallation of Empress package" -ForegroundColor Red -BackgroundColor Black
            deleteUninstallationSetupFiles -pathToUninstallScript $pathToEmpUninstallScript
        }
    } else {
        Write-Host "Skip uninstallation of Empress package" -ForegroundColor Red -BackgroundColor Black
        deleteUninstallationSetupFiles -pathToUninstallScript $pathToEmpUninstallScript
    }
}
