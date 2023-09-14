param (
    [Parameter(Mandatory=$true)]
    [string]$RepoName
)
function Test-Function {
    [CmdletBinding()] # This is required for the function to be recognized as a cmdlet
    param (
	[Parameter(Mandatory=$true)]
	[string]$Param1
    )
    Write-Host "Param1: $Param1"
}
# switch to open repo
#
function Open-Repo {
    param (
	[Parameter(Mandatory=$true)]
	[string]$RepoName
    )
    switch ($RepoName) {
	"code" { $RepoName = "vscode" }
    }
    code-insiders $RepoName
}
Write-Host "RepoName: $RepoName"
switch ($RepoName) {
    "crinmo" { code-insiders }
}
