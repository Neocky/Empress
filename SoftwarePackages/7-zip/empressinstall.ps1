<#
.SYNOPSIS
Downloads and executes the 7-zip installer.

.DESCRIPTION
This scirpt will download and install the latest stable 7-zip version

#>
$empressFolder = "C:\Empress\7-zip"
$downloadlink = "https://7-zip.org/a/7z1900-x64.exe"
$argumentList = '/S /D="C:\Empress\7-zip"'

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

installPackage -setupFolder $empressFolder -url $downloadlink -arguments $argumentList
