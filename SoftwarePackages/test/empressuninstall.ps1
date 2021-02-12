<#
.SYNOPSIS
Deletes test txt for testing purposes.

.DESCRIPTION
This scirpt will uninstall the test package.
#>
$empressFolder = "C:\Empress\firefox"
$uninstallerExe = "\TEST.txt"

function uninstallPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder,
        [Parameter()][String]$uninstaller
    )
    $uninstallerPath = $setupFolder + $uninstaller
    Try {
        Remove-Item $uninstallerPath
    } catch {
        Exit
    }
}

uninstallPackage -setupFolder $empressFolder -uninstaller $uninstallerExe