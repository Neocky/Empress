<#
.SYNOPSIS
Executes the package installation script. 

.DESCRIPTION
This script handles the execution of the package installation script (empressinstall.ps1) of the previously downloaded Empress Package.
#>

# Starts the empressinstall.ps1 from the package
function startPackageInstallScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$nameOfPackage,
        [Parameter(Mandatory=$true)][String]$pathToInstallScript
    )
    $validInstallScriptPath = Test-Path $pathToInstallScript
    if ($validInstallScriptPath -eq $true) {
        Write-Host "Execute Empress Installation Script"
        Try {
            Start-Process powershell $pathToInstallScript -Verb RunAs -WindowStyle Hidden -Wait
            deleteInstallationScript $pathToInstallScript
            Write-Host "Succesfully installed Empress Package" -ForegroundColor Green
        } catch {
            Write-Warning "Package couldn't be installed"
            Write-Host "Skip installation of Empress Package" -ForegroundColor Red -BackgroundColor Black
            deleteInstallationScript $pathToInstallScript
        }
    } else {
        Write-Host "Skip installation of Empress Package" -ForegroundColor Red -BackgroundColor Black
        deleteInstallationScript $pathToInstallScript
    }
}

# Deletes the empressinstall.ps1 file after completion
function deleteInstallationScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$pathToInstallScript
    )
    # Gets the folder of the package
    $deleteFolderPath = ($pathToInstallScript).Substring(0,$pathToInstallScript.IndexOf("\empressinstall.ps1"))
    if ($deleteFolderPath -like "C:\Empress\*") {
        Try {
            Remove-Item $deleteFolderPath -Recurse
        } catch {
            Write-Warning "Setup folder couldn't be deleted"
        }
    } else {
        Write-Warning "Setup folder couldn't be deleted"
    }
}