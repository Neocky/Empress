<#
.SYNOPSIS
Removes an Empress package.

.DESCRIPTION
This script will uninstall the Empress package.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][string[]]$packageName=@()
)

# Starts functions that downloads and execute the uninstallation script
function Remove-EmpPackage {
    param (
        [Parameter()][string[]]$packageName=@()
    )
    # Calls initializeOutput function in EmpConsoleFormat.ps1
    initializeOutput 

    # Calls checkRunAsAdmin function in checkElevatedConsole.ps1 
    # Check if this script is running in privileged mode
    checkRunAsAdmin
    $i = 0
    foreach ($elem in $packageName) {
        Write-Progress -Activity "Package uninstallation" -Status "Progress:"  -PercentComplete ($i/$packageName.Length *100) -CurrentOperation $packageName[$i]
        Write-Host "────  " -NoNewline
        Write-Host "Empress package: " -NoNewline
        Write-Host $packageName[$i].PadRight(21) -NoNewline -ForegroundColor Yellow
        Write-Host "────"

        $packageFolder = "C:\Empress\" + $packageName[$i]
        $packageFolderTest = Test-Path $packageFolder
        if ($packageFolderTest -eq $FALSE) 
        {
            Write-Warning "Empress package is not installed"
            Write-Host "Abort uninstallation of Empress package" -ForegroundColor Red -BackgroundColor Black
            Break
        }
        # Find the uninstall script in the package folder
        $uninstallPackageScriptPathh = downloadEmpPackage -namePackage $packageName[$i] -installationMode "uninstall" #calls downloadEmpPackage function in Download-EmpPackage.ps1

        # Starts the uninstall package script
        startPackageUninstallScript -nameOfPackage $packageName[$i] -pathToEmpUninstallScript $uninstallPackageScriptPathh

        Write-Host "────────────────────────────────────────────────"
        $i++
    }
    resetOuput
}
New-Alias -Name remp -Value Remove-EmpPackage -Description "Uninstalls an Empress package"

Export-ModuleMember -Function Remove-EmpPackage
Export-ModuleMember -Alias "remp"