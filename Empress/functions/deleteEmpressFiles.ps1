<#
.SYNOPSIS
Deletes the setup files of the installation. 

.DESCRIPTION
This script handles the execution of the package installation script [empressinstall.ps1] of the previously downloaded Empress Package.
#>

[CmdletBinding()]
param (
    [Parameter()][String]$pathToInstallScript,
    [Parameter()][String]$pathToUninstallScript
)


# cleans up installation folder after succesfull installation of package
# deletes empresssetup.exe & empressinstall.ps1 
function deleteInstallationSetupFiles {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$pathToInstallScript
    )
    $setupFolderPath = ("$pathToInstallScript").Substring(0,"$pathToInstallScript".IndexOf("empressinstall.ps1"))
    $setupExe = Get-ChildItem $setupFolderPath | Where-Object {$_.Name -eq "empresssetup.exe"}
    $setupExePath = "$setupFolderPath" + "$setupExe"
    if ($setupExe -like "empresssetup.exe") {
        Try {
            Remove-Item $setupExePath
            Remove-Item $pathToInstallScript
        } catch {
            Write-Warning "Setup exe couldn't be deleted"
        }
    } else {
        Write-Warning "Setup exe couldn't be found"
    }
}


# deletes file [empressuninstall.ps1]
function deleteUninstallationSetupFiles {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$pathToUninstallScript
    )
    if ($pathToUninstallScript -like "*empressuninstall.ps1") {
        Try {
            Remove-Item $pathToUninstallScript
        } catch {
            Write-Warning "Uninstall script couldn't be deleted"
        }
    } else {
        Write-Warning "Uninstall script couldn't be found"
    }
}


# Deletes the whole packagefolder in Execute-PackageInstallScript.ps1
function deleteInstallationFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$pathToInstallScript
    )
    $deleteInstallationFolderPath = ($pathToInstallScript).Substring(0,$pathToInstallScript.IndexOf("\empressinstall.ps1"))
    if ($deleteInstallationFolderPath -like "C:\Empress\*") {
        Try {
            Remove-Item $deleteInstallationFolderPath -Recurse
        } catch {
            Write-Warning "Package folder couldn't be deleted"
        }
    } else {
        Write-Warning "Package folder couldn't be found"
    }
}


# Deletes the whole packagefolder in Execute-PackageUninstallScript.ps1
function deleteUninstallationFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][String]$pathToUninstallScript
    )
    $deleteUninstallationFolderPath = ($pathToUninstallScript).Substring(0,$pathToUninstallScript.IndexOf("\empressuninstall.ps1"))
    if ($deleteUninstallationFolderPath -like "C:\Empress\*") {
        Try {
            Remove-Item $deleteUninstallationFolderPath -Recurse
        } catch {
            Write-Warning "Package folder couldn't be deleted"
        }
    } else {
        Write-Warning "Package folder couldn't be found"
    }
}
