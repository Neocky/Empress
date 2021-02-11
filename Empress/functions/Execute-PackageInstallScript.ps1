<#
.SYNOPSIS
Executes the package installation script. 

.DESCRIPTION
This script handles the execution of the package installation script [empressinstall.ps1] of the previously downloaded Empress Package.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][String]$nameOfPackage,
    [Parameter(Mandatory=$true)][String]$pathToInstallScript
)


# Starts the empressinstall.ps1 from the package
function startPackageInstallScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$nameOfPackage,
        [Parameter(Mandatory=$true)][String]$pathToInstallScript
    )
    $validInstallScriptPath = Test-Path $pathToInstallScript
    if ($validInstallScriptPath -eq $true) {
        Write-Host "Execute Empress installation script"
        Try {
            Start-Process powershell $pathToInstallScript -Verb RunAs -WindowStyle Hidden -Wait
            deleteInstallationSetupFiles -pathToInstallScript $pathToInstallScript
            Write-Host "Succesfully installed Empress package" -ForegroundColor Green
        } catch {
            Write-Warning "Package couldn't be installed"
            Write-Host "Skip installation of Empress package" -ForegroundColor Red -BackgroundColor Black
            deleteInstallationFolder -pathToInstallScript $pathToInstallScript
        }
    } else {
        Write-Host "Skip installation of Empress package" -ForegroundColor Red -BackgroundColor Black
        deleteInstallationFolder -pathToInstallScript $pathToInstallScript
    }
}
