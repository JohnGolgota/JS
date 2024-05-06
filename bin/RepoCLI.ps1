param (
[ValidateSet('seriedad')]
[string]$Repo = "NoRepoProvided"
)
try {
Write-Host "Repo: $Repo"
$repos = @{
"seriedad" = "c"
}
if ($repos.ContainsKey($Repo)) {
code-insiders $repos[$Repo]
} else {
code-insiders
}
}
catch {
Write-Host "Error: $($_.Exception.Message)"
}
