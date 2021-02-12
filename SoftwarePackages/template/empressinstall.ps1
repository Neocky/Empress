<#
.SYNOPSIS
Downloads and executes the PACKAGENAME installer.

.DESCRIPTION
This scirpt will download and install the latest PACKAGENAME version


TEMPLATE DESCRIPTION BELOW | CAN BE DELTED IN PACKAGE:

This is a template of an Empress package install script. 

Change values before use.

!!! DELTE THE LINE AT THE NEAR END WHERE IT SAYS SO OR SCRIPT WILL NOT RUN!!!

#>
$empressFolder = "C:\Empress\template"
$downloadlink = "https://example.com/download"
$argumentList = "/s /InstallDirectoryPath=$empressFolder /DesktopShortcut=false"

function installPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder,
        [Parameter()][String]$url,
        [Parameter()][String]$arguments
    )
    $installerPath = $setupFolder + "\empresssetup.exe"
    $webBrowser = New-Object System.Net.WebClient
    Try {
        $webBrowser.DownloadFile($url, $installerPath)
    } catch {
        Exit 1
    }
    Try {
        Start-Process -FilePath $installerPath -ArgumentList $arguments -Verb RunAs -Wait
    } catch {
        Exit 1
    }
}

# DELETE THE LINE BELOW ME (ONLY SO TEMPLATE DOESN'T EXECUTE ANYTHING UNWILLINGLY)
Exit 1

installPackage -setupFolder $empressFolder -url $downloadlink -arguments $argumentList