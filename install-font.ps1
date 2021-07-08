#!/bin/pwsh

<#
  .SYNOPSIS
    lzocateli00 PowerShell Install Font Meslo M Regular Windows
  .DESCRIPTION
    Download and install the Meslo font, which will be used in 
    PowerShell + posh-git customization, as well as in VsCode
  .LINK
    GitHub.com/lzocateli00 Twitter.com/lzocateli00
#>
[CmdletBinding()]
param ()

$fontName = 'Meslo LG M Regular Nerd Font Complete Windows Compatible.ttf'
$url = 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/'

$fontDestination = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$fontName"

Invoke-WebRequest -Uri "$url$fontName" -OutFile $fontDestination

if (Test-Path $fontDestination) {
    [System.IO.FileInfo]$fontFile = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$fontName"

    if ($PSCmdlet.ShouldProcess($fontFile.Name, "Install Font")) {
        $shellApp = New-Object -ComObject shell.application
        $fonts = $shellApp.NameSpace(0x14)
        $fonts.CopyHere($fontFile.FullName)
    }
    
}