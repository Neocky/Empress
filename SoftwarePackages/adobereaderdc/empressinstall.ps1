<#
.SYNOPSIS
Downloads and executes the adobereaderdc installer.

.DESCRIPTION
This scirpt will download and install the latest adobereaderdc version
#>
$empressFolder = "C:\Empress\adobereaderdc"
$downloadlink = "ftp://ftp.adobe.com/pub/adobe/reader/win/AcrobatDC/2001320064/AcroRdrDC2001320064_en_US.exe"
$argumentList = "/sAll /msi /norestart INSTALLDIR=$empressFolder AllUSERS=1 EULA_ACCEPT=YES"

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