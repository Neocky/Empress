<#
.SYNOPSIS
Creates a simple txt for testing purposes.

.DESCRIPTION
This script creates a simple textfile for testing purposes.
#>
$empressFolder = "C:\Empress\firefox"

function installPackage {
    [CmdletBinding()]
    param (
        [Parameter()][String]$setupFolder
    )
    $installerPath = $setupFolder + "\TEST.txt"
    Try {
        New-Item -Path $installerPath -ItemType File
    } catch {
        Exit 1
    }
}

installPackage -setupFolder $empressFolder
