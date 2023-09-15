# Usage: repo.ps1 -Repo <repo>
# Description: Open VSCode with the repo selected
param (
	[ValidateSet(
	'Lana'
	)]
	[string]$Repo = "NoRepoProvided"
)
try {
	Write-Host "Repo: $Repo"
	$repos = @{
		"Lana" = "lana.code-workspace"
		Default = ""
	}
	if ($repos.ContainsKey($Repo)) {
		code-insiders $repos[$Repo]
	} else {
		code-insiders
	}
}
catch {
	Write-Host "Error: $_"
}
