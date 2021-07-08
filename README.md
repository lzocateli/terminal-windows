### Personalizando PowerShell com posh-git + Oh My Posh

>Esse procedimento foi realizado no Windows 10 Pro Version 20H2 (build 19042.1052)   
PowerShell versão 5.1  
Tenha o VsCode já instalado   

#### 1. Instale o Windows Terminal ####   
**Abra o PowerShell - Como Administrador**

- dddd

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
#### 5. Configure a fonte para reconhecer os caracteres do git e da linha de comando ####  
- Execute esse comando no seu terminal PowerShell:

```powershell
Invoke-WebRequest -Uri "https://github.com/lzocateli00/terminal-windows/blob/main/install-font.ps1" -OutFile "$($HOME)/Downloads/install-font.ps1"
```
- Execute os comandos: (Caso necessite elevação de acesso, feche o PowerShell atual e abra um novo como Administrador)

```powershell
cd $HOME/Downloads/
./install-font.ps1
```