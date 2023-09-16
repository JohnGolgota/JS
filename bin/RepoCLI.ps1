param (
[ValidateSet('fuck')]
[string]$Repo = "NoRepoProvided"
)
try {
Write-Host "Repo: $Repo"
$repos = @{
"fuck" = "c"
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
