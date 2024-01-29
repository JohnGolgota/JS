$moduleInfo = @{
    Path              = (Join-Path $env:JS "bin\pwshModuls\CustomUserUtils.psd1")
    Author            = "JissG"
    FunctionsToExport = 'Get-CodeWorkspace', 'Set-TempEnvFromFile', 'AdivinarNombre'
}

New-ModuleManifest @moduleInfo

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

# New-ModuleManifest
# [-Path] <String>
# [-NestedModules <Object[]>]
# [-Guid <Guid>]
# [-Author <String>]
# [-CompanyName <String>]
# [-Copyright <String>]
# [-RootModule <String>]
# [-ModuleVersion <Version>]
# [-Description <String>]
# [-ProcessorArchitecture <ProcessorArchitecture>]
# [-PowerShellVersion <Version>]
# [-CLRVersion <Version>]
# [-DotNetFrameworkVersion <Version>]
# [-PowerShellHostName <String>]
# [-PowerShellHostVersion <Version>]
# [-RequiredModules <Object[]>]
# [-TypesToProcess <String[]>]
# [-FormatsToProcess <String[]>]
# [-ScriptsToProcess <String[]>]
# [-RequiredAssemblies <String[]>]
# [-FileList <String[]>]
# [-ModuleList <Object[]>]
# [-FunctionsToExport <String[]>]
# [-AliasesToExport <String[]>]
# [-VariablesToExport <String[]>]
# [-CmdletsToExport <String[]>]
# [-DscResourcesToExport <String[]>]
# [-CompatiblePSEditions <String[]>]
# [-PrivateData <Object>]
# [-Tags <String[]>]
# [-ProjectUri <Uri>]
# [-LicenseUri <Uri>]
# [-IconUri <Uri>]
# [-ReleaseNotes <String>]
# [-Prerelease <String>]
# [-RequireLicenseAcceptance]
# [-ExternalModuleDependencies <String[]>]
# [-HelpInfoUri <String>]
# [-PassThru]
# [-DefaultCommandPrefix <String>]
# [-WhatIf]
# [-Confirm] 
# [<CommonParameters>]