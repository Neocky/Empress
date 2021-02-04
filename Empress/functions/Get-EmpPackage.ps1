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

# Check if module is run as Administrator
function checkRunAsAdmin {
    if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "Command needs to be run as administrator! Creating UAC prompt"
        Write-Host "                                    3"
        Start-Sleep -Seconds 1
        Write-Host "                                    2"
        Start-Sleep -Seconds 1
        Write-Host "                                    1"
        Start-Sleep -Seconds 1
        Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs -WindowStyle Hidden
        #Break
    }
}


# Starts functions that download and execute the installation script
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
        #Write-Host $packageName[$i]
        Write-Host "────  " -NoNewline
        #Write-Host "👑".PadRight(3) -NoNewline
        Write-Host "Empress Package: " -NoNewline
        Write-Host $packageName[$i].PadRight(21) -NoNewline -ForegroundColor Yellow
        Write-Host "────"
        # Find the install script in the package folder
        $installPackageScriptPathh = downloadEmpPackage $packageName[$i] #calls downloadEmpPackage function in Download-EmpPackage.ps1

        # Starts the install package script
        startPackageInstallScript -nameOfPackage $packageName[$i] -pathToInstallScript $installPackageScriptPathh

        #deleteInstallationScript -installationScriptPath $pathToInstallScript
        
        Write-Host "────────────────────────────────────────────────"
        $i++
    }
    resetOuput
}
New-Alias -Name gemp -Value Get-EmpPackage -Description "Installs an Empress Package"

Export-ModuleMember -Function Get-EmpPackage
Export-ModuleMember -Alias "gemp"