<#
.SYNOPSIS
Executes the 7-zip uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed 7-zip version.

#>
$empressFolder = "C:\Empress\7-zip"
$uninstallerExe = "\Uninstall.exe"
$argumentList = "/S"

function uninstallPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder,
        [Parameter()][String]$uninstaller,
        [Parameter()][String]$arguments
    )
    $uninstallerPath = $setupFolder + $uninstaller
    Try {
        Start-Process -FilePath $uninstallerPath -ArgumentList $arguments -Verb RunAs -Wait
    } catch {
        Exit
    }
}

uninstallPackage -setupFolder $empressFolder -uninstaller $uninstallerExe  -arguments $argumentList