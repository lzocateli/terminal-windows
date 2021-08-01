### Personalizando PowerShell com posh-git + Oh My Posh

>Esse procedimento foi realizado no Windows 10 Pro Version 20H2 (build 19042.1052)   
PowerShell versão 5.1  
Tenha o VsCode já instalado   

#### 1. Instale o Windows Terminal ####   
**Abra o PowerShell - Como Administrador**

- choco install microsoft-windows-terminal

#### 2. Instale o modulo do powershell para o posh-git ####  
**Abra o PowerShell - Sem Administrador**

- Esse módulo é responsável por integrar o Git ao PowerShell   

```powershell
Install-Module posh-git -Scope CurrentUser -Force
```

#### 3. Instale o modulo oh-my-posh ####   
**Continue com o PowerShell aberto**

- Esse módulo permite a personalização de temas e fontes mais amigáveis.   
- Veja a documentação [aqui](https://ohmyposh.dev/docs/) para escolher seu tema preferido, caso o tema que sugiro não te agrade.   
- O módulo PSReadLine permite a personalização da linha de comando.

```powershell
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module PSReadLine -Scope CurrentUser -Force
Import-Module PSReadLine
```

#### 4. Edite o "profile" do PowerShell e inclua as seguintes instruções ###   
**Continue com o PowerShell aberto**   

- É aqui que vamos configurar o PowerShell para usar os modulos que instalamos, e também configurar o tema.   

- Como bonus, estou incluindo "alias" para o comando "ls" (Get-ChildItem), com e sem paginação.   

Edite o profile do seu perfil do PowerShell: 

```powershell
code $PROFILE
```
Copie as linhas abaixo:

```powershell
Import-Module posh-git   
Import-Module oh-my-posh   
Set-PoshPrompt -Theme slimfat  
 
function AliasLLL {
    Get-ChildItem -Force | more
}
function AliasLL {
    Get-ChildItem -Force
}

Set-Alias lll AliasLLL -Option AllScope
Set-Alias ll AliasLL -Option AllScope
```
#### 5. Instale a fonte para reconhecer os caracteres do git e da linha de comando ####  
- Execute esse comando no seu terminal PowerShell: crie um arquivo install-font.ps1 com o conteudo abaixo ou baixe o zip e extraia apenas a fonte "Meslo LG M Regular Nerd Font Complete Windows Compatible.ttf" click [aqui](https://ohmyposh.dev/docs/fonts) para baixar o zip

```powershell
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
```
- Execute os comandos: (Caso necessite elevação de acesso, feche o PowerShell atual e abra um novo como Administrador)

```powershell
cd $HOME/Downloads/
./install-font.ps1
```
**ou instale manualmente a fonte:**   

![Windows install fonts](https://github.com/lzocateli00/terminal-windows/blob/708d98718cd7c713263865c3ecd4c1bccdb61c78/images/Windows%20Install%20font.jpg)

#### 6. Configure a fonte para o Windows Terminal (PowerShell) ####  

![Windows Start](https://github.com/lzocateli00/terminal-windows/blob/37631020d9abeac1802e29231de79cd14d17f561/images/WindowsTerminal.png)

![Windows Terminal-Settings](https://github.com/lzocateli00/terminal-windows/blob/37631020d9abeac1802e29231de79cd14d17f561/images/WindowsTerminal-Settings.png)

![PowerShell-Font](https://github.com/lzocateli00/terminal-windows/blob/37631020d9abeac1802e29231de79cd14d17f561/images/PowerShell-Font.png)

- Feche o Windows Terminal
- Abra o Windows Terminal, sua linha de comando, em uma pasta de projeto com git, com dotnet, deve ter essa aparencia:

![Win Terminal](https://github.com/lzocateli00/terminal-windows/blob/019b2b87148053b683626f3e267a132b59d28365/images/WindowsTerminal-Final.png)

- Se quiser personalizar, abra o arquivo do tema que fica nessa pasta: "\Documentos\WindowsPowerShell\Modules\oh-my-posh\3.168.0\themes\slimfat.omp.json"

 #### 7. Configure a fonte para o terminal do VsCode ####  

- Abra o VsCode, depois vá para as configurações do usuario ( CTRL + , )
- Configure a fonte para o terminal, copie no campo indicado: MesloLGM NF   

![VsCode Font](https://github.com/lzocateli00/terminal-windows/blob/37631020d9abeac1802e29231de79cd14d17f561/images/VsCode-Meslo.png)

- Pode fechar o vscode e abrir novamente, o terminal já estara com a nova configuração.


- Referencias: [Unicode Table](https://unicode-table.com/en)
