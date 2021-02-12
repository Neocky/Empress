<#
.SYNOPSIS
Executes the PACKAGENAME uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed PACKAGENAME version.


TEMPLATE DESCRIPTION BELOW | CAN BE DELTED IN PACKAGE:

This is a template of an Empress package install script. 

Change values before use.

!!! DELTE THE LINE AT THE NEAR END WHERE IT SAYS SO OR SCRIPT WILL NOT RUN!!!

#>
$empressFolder = "C:\Empress\template"
$uninstallerExe = "\uninstall.exe"
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

# DELETE THE LINE BELOW ME (ONLY SO TEMPLATE DOESN'T EXECUTE ANYTHING UNWILLINGLY)
Exit 1

uninstallPackage -setupFolder $empressFolder -uninstaller $uninstallerExe  -arguments $argumentList