<#
.SYNOPSIS
Downloads the empinstall.ps1 script from github

.DESCRIPTION
This script handles the download of the empressinstall.ps1 of the package.
This script gets called through the function downloadEmpPackage.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][String]$namePackage
)

# Creates package folder if not existent
function createPackageFolder {
    $packageFolder = "C:\Empress\" + "$namePackage"
    $packageFolderTest = Test-Path $packageFolder
    Write-Debug "packageFolderTest: $packageFolderTest"
    if ($packageFolderTest -eq $TRUE) 
    {
        $packageFolderPath = "C:\Empress\" + "$namePackage"
    } else {
        $packageFolderPath = New-Item -Path $packageFolder -ItemType "directory"
    }
    Write-Debug "createPackageFolder: $packageFolderPath"
    return $packageFolderPath
}

# Calls function createPackageFolder
# Creates the path to the empressinstall.ps1
function createInstallScript {
    $installScriptPath = createPackageFolder
    Write-Debug "createInstallScript: $installScriptPath"
    $installScriptPathNew = "$installScriptPath" + "\empressinstall.ps1"
    Write-Debug "createInstallScript: $installScriptPathNew"
    return $installScriptPathNew
}

# Creates downloadlink from template and the packagename
function createDownloadLink {
    $softwarePackagesLink = "https://raw.githubusercontent.com/Neocky/Empress/main/SoftwarePackages/" + $namePackage + "/empressinstall.ps1"
    return $softwarePackagesLink
}

# Calls function createDownloadLink & createInstallScript
# Downloads the empressinstall.ps1 into the right folder
function downloadInstallScript {
    $url = createDownloadLink
    $targetFolderPath = createInstallScript # $installScriptPathhh
    Write-Debug "URL: $url"
    Write-Debug "Zielpfad: $targetFolderPath"
    $WebClient = [System.Net.WebClient]::new()
    try {
        Write-Host "Start Empress Package Download"#:                 $namePackage"
        $WebClient.DownloadFile($url, $targetFolderPath)
        #Write-Host "Install Empress Package:                        $namePackage"
    } catch [System.Net.WebException] {
        if([int]$_.Exception.Response.StatusCode -eq 404)
            {
                Write-Warning "Empress Package doesn't exist"
            } else {
                Write-Warning "Empress Package couldn't be downloaded" #-ForegroundColor Red
                Write-Warning "Check packagename and connection to the internet" #-ForegroundColor Yellow
            }
        
        #resetOuput
        #Break
    } 
    return $targetFolderPath
}

# Main function that gets called and handles the download of the empressinstall.ps1 file and returns the path to the empressinstall.ps1
function downloadEmpPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$namePackage
    )
    $pathtargetFolder = downloadInstallScript
    return $pathtargetFolder
}
