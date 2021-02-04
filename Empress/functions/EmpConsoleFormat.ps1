<#
.SYNOPSIS
Sets the Output of the PowerShell console window. 

.DESCRIPTION
Formats the PowerShell console window.
#>

function initializeOutput {
    $host.UI.RawUI.WindowTitle = "👑 Empress | $([char]0x00A9) Neocky 2021"
}

function resetOuput {
    $host.UI.RawUI.WindowTitle = "Administrator: Windows PowerShell"
}
