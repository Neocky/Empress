<#
.SYNOPSIS
Executes the lenovosystemupdate uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed lenovosystemupdate version.
#>
$empressFolder = "C:\Empress\lenovosystemupdate"
$uninstallerExe = "\unins000.exe"
$argumentList = "/VERYSILENT"

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