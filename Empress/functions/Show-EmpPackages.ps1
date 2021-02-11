<#
.SYNOPSIS 
Show-EmpPackages

.DESCRIPTION
Shows all installed Empress packages.

Alias:
semp
#>

# prints out all installed empress packages
function Show-EmpPackages {
    initializeOutput
    $empressPackages = Get-ChildItem -Path "C:\Empress\" -Directory
    Write-Host "Installed Empress packages:" -ForegroundColor Green
    Write-Host $empressPackages 
    resetOuput
}
New-Alias -Name semp -Value Show-EmpPackages -Description "Shows all installed Empress packages."

Export-ModuleMember -Function Show-EmpPackages
Export-ModuleMember -Alias "semp"