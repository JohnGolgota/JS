function Set-CustomMain
{
    try
    {
        . $Env:JS\bin\pwshModuls\Set-CustomAlias.ps1
        . $Env:JS\bin\RepoCli-Utils.ps1
        . $Env:JS\.config\profile.pwsh.ps1
        . $PROFILE
    } catch
    {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

function Get-CodeWorkspace
{
    $folderInfo = Get-Item .
    $folderName = $folderInfo.Name
    $CodeWorkspace = Get-ChildItem -Path . -Filter *.code-workspace -Recurse -ErrorAction SilentlyContinue
    if ($null -eq $CodeWorkspace)
    {
        Write-Host "No se encontró ningún archivo .code-workspace"
        Copy-Item -Path "$env:JS\copy\example.code-workspace" -Destination "./$folderName.code-workspace"
    } else
    {
        Write-Host "Se encontró el archivo .code-workspace"
    }
}

function Set-TempEnvFromFile
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$EnvFile
    )
    Get-Content $EnvFile | ForEach-Object {
        $name, $value = $_ -split "="
        Set-Content env:\$name $value
    }
}

function Hola
{
    Write-Host "Voy a adivinar tu nombre"
    $Nombre = Read-Host "¿Cómo te llamas?"
    Write-Host "Tu nombre es $Nombre"
    curl ascii.live/donut
}

function Update-JS
{
    $currentDir = Get-Location
    Set-Location $Env:JS
    git pull
    Set-Location $currentDir
}