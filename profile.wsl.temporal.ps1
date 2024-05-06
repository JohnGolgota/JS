$env:JS = "/mnt/c/JS"
$env:MY_PATHS = "$env:JS\bin\pwshModuls\RepoCli\private_hashtable.ps1;$env:JS\bin\repo.ps1"

<#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/jiss/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#>

Set-PSReadLineOption -EditMode Windows

. Custom_Funciones.ps1
Set-CustomMain