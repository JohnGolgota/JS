$Alias = @{
    "x" = "nvim"
    "c" = "code-insiders"
    "z" = "tmux"
}

$Alias.GetEnumerator() | ForEach-Object {
    $name = $_.Name
    $value = $_.Value
    if (Get-Command $value -ErrorAction SilentlyContinue) {
        Set-Alias -Name $name -Value $value -Option AllScope -Scope Global
    }

}