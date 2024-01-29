
try {
    Write-Host "Custom-Main"
    . $env:JS\bin\pwshModuls\Set-CustomAlias.ps1
}
catch {
    Write-Host "Error: $($_.Exception.Message)"
}
