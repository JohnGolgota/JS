. $Env:JS\bin\pwshModuls\Alias_enum.ps1

$Alias.GetEnumerator() | ForEach-Object {
    $name = $_.Name
    $value = $_.Value
    if (Get-Command $value -ErrorAction SilentlyContinue) {
        Set-Alias -Name $name -Value $value -Option AllScope -Scope Global
    }
}