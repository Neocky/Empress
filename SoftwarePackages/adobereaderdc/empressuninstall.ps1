<#
.SYNOPSIS
Executes the adobereaderdc uninstaller.exe.

.DESCRIPTION
This scirpt will uninstall the installed adobereaderdc version.
#>
#$empressFolder = "C:\Empress\adobereaderdc"
$uninstallerExe = "$env:systemroot\system32\msiexec.exe"
$argumentList = "/x {AC76BA86-7AD7-1031-7B44-AC0F074E4100} /qn"

function uninstallPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder,
        [Parameter()][String]$uninstaller,
        [Parameter()][String]$arguments
    )
    $uninstallerPath = $uninstaller <#$setupFolder +#>
    Try {
        Start-Process -FilePath $uninstallerPath -ArgumentList $arguments -Verb RunAs -Wait
    } catch {
        Exit
    }
}

uninstallPackage -setupFolder $empressFolder -uninstaller $uninstallerExe  -arguments $argumentList