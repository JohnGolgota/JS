function Set-CustomMain {
    try {
        . $env:JS\bin\pwshModuls\Set-CustomAlias.ps1
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

function Import-CustomModules {
    try {
        Import-Module $env:JS\bin\pwshModuls\CustomUserUtils.psm1
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }    
}

function Get-CodeWorkspace {
    $folderInfo = Get-Item .
    $folderName = $folderInfo.Name
    $CodeWorkspace = Get-ChildItem -Path . -Filter *.code-workspace -Recurse -ErrorAction SilentlyContinue
    if ($null -eq $CodeWorkspace) {
        Write-Host "No se encontró ningún archivo .code-workspace"
        Copy-Item -Path "$env:JS\copy\example.code-workspace" -Destination "./$folderName.code-workspace"
    }
    else {
        Write-Host "Se encontró el archivo .code-workspace"
    }
}

function Set-TempEnvFromFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$EnvFile
    )
    Get-Content $EnvFile | ForEach-Object {
        $name, $value = $_ -split "="
        Set-Content env:\$name $value
    }
}

function AdivinarNombre {
    Write-Host "Voy a adivinar tu nombre"
    $Nombre = Read-Host "¿Cómo te llamas?"
    Write-Host "Tu nombre es $Nombre"
    curl ascii.live/donut
}