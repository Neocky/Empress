<#
.SYNOPSIS
Gets and executes the PowerShell script file for a specific software package. 

.DESCRIPTION
Accepts an array of strings as input.

.NOTES

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)][string[]]$packageName=@()
)


# Starts functions that downloads and execute the installation script
function Get-EmpPackage {
    param (
        [Parameter()][string[]]$packageName=@()
    )
    initializeOutput #calls initializeOutput function in EmpConsoleFormat.ps1

    # Check if this script is running in privileged mode
    checkRunAsAdmin
    $i = 0
    foreach ($elem in $packageName) {
        Write-Progress -Activity "Package Installation" -Status "Progress:"  -PercentComplete ($i/$packageName.Length *100) -CurrentOperation $packageName[$i]
        Write-Host "────  " -NoNewline
        Write-Host "Empress Package: " -NoNewline
        Write-Host $packageName[$i].PadRight(21) -NoNewline -ForegroundColor Yellow
        Write-Host "────"
        # Find the install script in the package folder
        $installPackageScriptPathh = downloadEmpPackage -namePackage $packageName[$i] -installationMode "install" #calls downloadEmpPackage function in Download-EmpPackage.ps1

        # Starts the install package script
        startPackageInstallScript -nameOfPackage $packageName[$i] -pathToInstallScript $installPackageScriptPathh
        
        Write-Host "────────────────────────────────────────────────"
        $i++
    }
    resetOuput
}
New-Alias -Name gemp -Value Get-EmpPackage -Description "Installs an Empress package"

Export-ModuleMember -Function Get-EmpPackage
Export-ModuleMember -Alias "gemp"