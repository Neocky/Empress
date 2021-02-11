<#
.SYNOPSIS
Executes the firefox uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed firefox version.
#>
$empressFolder = "C:\Empress\firefox"
$uninstallerExe = "\uninstall\helper.exe"
$argumentList = "/s"

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