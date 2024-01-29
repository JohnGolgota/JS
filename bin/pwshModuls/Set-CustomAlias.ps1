$Alias = @{
    "x" = "nvim"
    "c" = "code-insiders"
    "z" = "tmux"
}

$AliasErr = @()

$Alias.GetEnumerator() | ForEach-Object {
    $name = $_.Name
    $value = $_.Value
    if (Get-Command $value -ErrorAction SilentlyContinue) {
        Set-Alias -Name $name -Value $value -Option AllScope -Scope Global
    }
    else {
        $Alias:Err += $value
    }
}

if ($AliasErr.Count -gt 0) {
    Write-Host "No se encontraron los siguientes comandos: $($AliasErr -join ", ")"
}