$VarsRepositoryPath = "${HOME}/temp/vars.json"

if (-not (Test-Path $VarsRepositoryPath)) {
    New-Item $VarsRepositoryPath -Type File -Force
}

function Save-CustomVars {
    param(
        [String]$Name = "back"
    )
    process {
        $Value = $_
        # Cargar el archivo JSON existente
        $VarsItem = Get-Item $VarsRepositoryPath
        $Vars = Get-Content $VarsItem.FullName | ConvertFrom-Json

        # Convertir el objeto JSON a un hashtable para poder agregar propiedades
        $VarsHashtable = @{}
        $Vars.PSObject.Properties | ForEach-Object {
            $VarsHashtable[$_.Name] = $_.Value
        }

        # Agregar la nueva propiedad
        $VarsHashtable[$Name] = $Value

        # Convertir el hashtable nuevamente a JSON
        $VarsUpdated = $VarsHashtable | ConvertTo-Json

        # Guardar el JSON actualizado en el archivo
        $VarsUpdated | Set-Content $VarsRepositoryPath
    }
}

function Spread-CustomVars {
    $VarsItem = Get-Item $VarsRepositoryPath
    $Vars = Get-Content $VarsItem.FullName | ConvertFrom-Json
    $Vars.PSObject.Properties | ForEach-Object {
        Write-Host "`$$($_.Name)"
        Set-Variable -Name $_.Name -Value $_.Value -Scope Global
    }
    Write-Host "CustomVars loaded"
}