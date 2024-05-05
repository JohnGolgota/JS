# Instala el módulo PSSQLite desde PowerShell Gallery
Install-Module -Name PSSQLite

# Importa el módulo
Import-Module -Name PSSQLite

# # Ejemplo de uso
# Invoke-SQLiteQuery -DataSource ".\.data\main.db" -Query "SELECT * FROM sources"

$temporal_csv = ".\temporal.csv"
if(-not(Test-Path $temporal_csv)) {
    New-Item -Path $temporal_csv -ItemType File
}
# Import-Csv -Path $temporal_csv | ForEach-Object {
    #     $query = "INSERT INTO programs (id, name, 'source', i_use_that) VALUES ('$($_.Id)', '$($_.Nombre)', 1, 1)"
#     # $query
#     Invoke-SQLiteQuery -DataSource ".\.data\main.db" -Query $query
# }


$query = "SELECT * FROM programs WHERE `source` = 1 and i_use_that = 1"
$resultado = Invoke-SQLiteQuery -DataSource ".\.data\main.db" -Query $query
if ($resultado.Count -eq 0) {
    Write-Host "No hay programas para insertar"
    return
}
$resultado | ForEach-Object {
    Add-Content -Path $temporal_csv -Value "$($_.id)"
}