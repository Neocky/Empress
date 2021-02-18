<#
.SYNOPSIS
Downloads and executes the lenovosystemupdate installer.

.DESCRIPTION
This scirpt will download and install the latest lenovosystemupdate version
#>
$empressFolder = "C:\Empress\lenovosystemupdate"
$downloadlink = "https://download.lenovo.com/pccbbs/thinkvantage_en/system_update_5.07.0117.exe"
$argumentList = "/VERYSILENT /NORESTART /DIR=$empressFolder"

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