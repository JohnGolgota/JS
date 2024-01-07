# Config

## steps

1. [winget](#winget)
2. [Git](#git)
3. [GitHub Desktop](#github-desktop)
4. [vscode](#visual-studio-code)
5. [wsl2](#windows-subsystem-for-linux)

## Steps Reduce

1. [Winget](#winget)
2. [Git](#git)
3. [powershell](#powershell)
4. [vscode](#visual-studio-code)

## [Winget](https://learn.microsoft.com/es-es/windows/package-manager/winget/)

### instalacion

From [github](https://github.com/microsoft/winget-cli/releases) with o [microsoft store](https://apps.microsoft.com/detail/9NBLGGH4NNS1?hl=es-co&gl=CO)

## [Git](https://git-scm.com/download/win)

<!-- Puta Session -->
instalacion... seh, una mierda

```bash
winget install --id Git.Git -e --source winget
```

si obvio

```bash
git config --global user.name "JohnGolgota"
git config --global user.email "js684new@gmail.com"
```

environtments

```bash
# opcion 1 script
$envName = "MY_VAR"
$envValue = "my_value"

New-ItemProperty -Path "HKCU:\Environment" -Name $envName -Value $envValue -PropertyType "String" -Force
# o usar el menu de windows
```

repositorios principales

```bash
git clone https://github.com/JohnGolgota/tru-01.git $HOME/tru-01
git clone https://github.com/JohnGolgota/JS.git $env:JS
```

### script para la instalación de mis programas

La forma de manejar la importación me pareció incómoda, sobre todo al resaltar las aplicaciones o buscar agregar información extra. Podría usarlo, si importara conjuntos más pequeños de aplicaciones relacionadas... pero mucho archivo, paso.

```bash
# winget import $JS/.config/winget.json --ignore-unavailable --ignore-version --no-upgrade
. winget.list.ps1
```

## [GitHub Desktop](https://desktop.github.com/)
<!-- Session -->
me basta con abrir los repositorios principales.

```bash
github $HOME/tru-01
github $env:JS
```

## [Scoop](https://github.com/ScoopInstaller/Install#installation)

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

```bash
irm get.scoop.sh | iex
# You can use proxies if you have network trouble in accessing GitHub, e.g.
irm get.scoop.sh -Proxy 'http://<ip:port>' | iex
```

## [Visual Studio Code](https://code.visualstudio.com/)
<!-- Session -->
```bash
winget install --id Microsoft.VisualStudioCode.Insiders -e --source winget
winget install --id Microsoft.VisualStudioCode -e --source winget
```

```bash
code $HOME/tru-01/.configuration/config.code-workspace
code-insiders $HOME/tru-01/.configuration/config.code-workspace
```

## [Node JS](https://nodejs.org/es)

### [nvm](https://github.com/coreybutler/nvm-windows#reinstall-any-global-utilities)

```bash
nvm install --lts
```

### [pnpm](https://pnpm.io/es/installation)

## [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.3)

despues de instalar winget y git con mis repositorios principales clonados

```bash
winget install --id Microsoft.PowerShell -e --source winget
```

```bash
pwsh $HOME/tru-01/.configuration/config.pwsh.ps1
```
