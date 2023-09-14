# example 1 hashtable: Open-Repo.ps1 -OpenRepo
param (
	[ValidateSet('true','false')]
	[string]$OpenRepo = 'true'
)
Write-Host "OpenRepo: $OpenRepo"

$repos = @{
	'true' = { code-insiders ".code-workspace" }
	'false' = { code-insiders ".code-workspace" }
	default = { code-insiders }
}
if ($repos.ContainsKey($OpenRepo)) {
	$repos[$OpenRepo].Invoke()
} else {
	$repos['default'].Invoke()
}
# example 2 switch: Open-Repo.ps1 -OpenRepo $true
param (
	[ValidateSet('true','false')]
	[string]$OpenRepo
)
Write-Host "OpenRepo: $OpenRepo"
switch ($OpenRepo) {
	'true' { code-insiders ".code-workspace" }
	'false' { code-insiders ".code-workspace" }
	default { code-insiders }
}
