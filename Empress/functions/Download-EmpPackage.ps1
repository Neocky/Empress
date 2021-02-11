<#
.SYNOPSIS
Downloads the empinstall.ps1 script from github

.DESCRIPTION
This script handles the download of the [empressinstall.ps1] of the package.
This script gets called through the function (downloadEmpPackage).
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][String]$namePackage,
    [Parameter(Mandatory=$true)][String]$installationMode
)

# Creates package folder if not existent
function createPackageFolder {
    $packageFolder = "C:\Empress\" + "$namePackage"
    $packageFolderTest = Test-Path $packageFolder
    if ($packageFolderTest -eq $TRUE) 
    {
        if ($installationMode -eq "uninstall") {
            $packageFolderPath = "C:\Empress\" + "$namePackage"
        } else {   
            Write-Warning "Package exists already"
            Write-Host "Abort installation of Empress package" -ForegroundColor Red -BackgroundColor Black
            Break
        }
    } else {
        $packageFolderPath = New-Item -Path $packageFolder -ItemType "directory"
    }
    return $packageFolderPath
}

# Calls function createPackageFolder
# Creates the path to the empressinstall.ps1
function createInstallScript {
    $installScriptPath = createPackageFolder
    if ($installationMode -eq "install") {
        $installScriptPathNew = "$installScriptPath" + "\empressinstall.ps1"
    }
    if ($installationMode -eq "uninstall") {
        $installScriptPathNew = "$installScriptPath" + "\empressuninstall.ps1"
    }
    return $installScriptPathNew
}

# Creates downloadlink from template and the packagename
function createDownloadLink {
    if ($installationMode -eq "install") {
        $softwarePackagesLink = "https://raw.githubusercontent.com/Neocky/Empress/main/SoftwarePackages/" + $namePackage + "/empressinstall.ps1"
    }
    if ($installationMode -eq "uninstall") {
        $softwarePackagesLink = "https://raw.githubusercontent.com/Neocky/Empress/main/SoftwarePackages/" + $namePackage + "/empressuninstall.ps1"
    }
    return $softwarePackagesLink
}

# Calls function createDownloadLink & createInstallScript
# Downloads the empressinstall.ps1 into the right folder
function downloadEmpressScript {
    $url = createDownloadLink
    $targetFolderPath = createInstallScript # $installScriptPathhh
    $WebClient = [System.Net.WebClient]::new()
    try {
        Write-Host "Start Empress package download"
        $WebClient.DownloadFile($url, $targetFolderPath)
    } catch [System.Net.WebException] {
        if([int]$_.Exception.Response.StatusCode -eq 404) {
                Write-Warning "Empress Package doesn't exist"
            } else {
                Write-Warning "Empress Package couldn't be downloaded"
                Write-Warning "Check packagename and connection to the internet"
            }
        resetOuput
        Break
    } 
    return $targetFolderPath
}

# Main function that gets called and handles the download of the empressinstall.ps1 file and returns the path to the empressinstall.ps1
function downloadEmpPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$namePackage,
        [Parameter()][String]$installationMode
    )
    $pathtargetFolder = downloadEmpressScript
    return $pathtargetFolder
}
