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


$fontNameDownload = 'Meslo LG M Regular Nerd Font Complete Windows Compatible.ttf'
$url = 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/Regular/complete/'

$fontDestination = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\"

if (-not(Test-Path -Path "$fontDestination$fontNameDownload")) {
    Invoke-WebRequest -Uri "$url$fontNameDownload" -OutFile "$fontDestination$fontNameDownload"
}

Write-Output "Install fonts"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)

foreach ($file in Get-ChildItem "$fontDestination\*.ttf") {
    $fileName = $file.Name

    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName")) {
        Write-Output "Copindo para: c:\windows\fonts\$fileName"

        Get-ChildItem $file | ForEach-Object { 
            try {
                
                $fonts.CopyHere($_.fullname) 
            }
            catch {
                write-warning $_.exception.message
                
            }
        }
  
        Copy-Item $file.FullName c:\windows\fonts\ -Force

    }
}
