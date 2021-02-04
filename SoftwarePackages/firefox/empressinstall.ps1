<#
.SYNOPSIS
Downloads and executes the firefox installer.

.DESCRIPTION
This scirpt will download and install the latest firefox version
#>
$empressFolder = "C:\Empress\firefox"
$downloadlink = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
$argumentList = "/s"

function installPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder,
        [Parameter()][String]$url,
        [Parameter()][String]$arguments
    )
    $installerPath = $setupFolder + "\setup.exe"
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

installPackage -setupFolder $empressFolder -url $downloadlink -arguments $argumentList