. $Env:JS\bin\pwshModuls\Alias_enum.ps1

Set-Content -Path $Env:JS\bin\PS_Alias.ps1 -Value ""

$Alias.GetEnumerator() | ForEach-Object {
    $name = $_.Name
    $value = $_.Value
    if (Get-Command $value -ErrorAction SilentlyContinue) {
        Add-Content -Path $Env:JS\bin\PS_Alias.ps1 -Value "Set-Alias -Name $name -Value $value -Option AllScope -Scope Global"
    }
}