<#
.SYNOPSIS
Executes the adobereaderdc uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed adobereaderdc version.
#>
$uninstallerExe = "msiexec.exe"
$argumentList = "/x {AC76BA86-7AD7-1033-7B44-AC0F074E4100} /qn"

function uninstallPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$uninstaller,
        [Parameter()][String]$arguments
    )
    $uninstallerPath = $uninstaller
    Try {
        Start-Process -FilePath $uninstallerPath -ArgumentList $arguments -Verb RunAs -Wait
    } catch {
        Exit
    }
}

uninstallPackage -uninstaller $uninstallerExe -arguments $argumentList