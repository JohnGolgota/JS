# Description: Test script for VS Code
#

$MyPaths = $env:MY_PATHS -split ";"
$RepoHashPath = $MyPaths[0]
$RepoCLIPath = $MyPaths[1]

Set-Variable -Name "splitedEnv" -Value $env:Path.Split(";")

function Add-RepoToHashtable {
	param (
		[Parameter(Mandatory = $true)]
		[string]$NewRepoName,

		[Parameter(Mandatory = $true)]
		[string]$NewRepoPath
	)
	$RepoHash = @{}
	$RepoNames = @()
	. $RepoHashPath
	# TODO validate if repo exists
	$RepoHash.Add($NewRepoName, $NewRepoPath)

	Set-Content -Path $RepoHashPath -value '$RepoHash = @{'
	foreach ($Repo in $RepoHash.GetEnumerator()) {
		Add-Content -Path $RepoHashPath -value "`"$($Repo.Key)`"=`"$($Repo.Value)`""
		# array from hashtable keys
		$RepoNames += $Repo.Key
	}
	Add-Content -Path $RepoHashPath -value "}"

	# add string from var $RepoNames
	Add-Content -Path $RepoHashPath -value '$RepoNames = @('
	foreach ($RepoName in $RepoNames) {
		Add-Content -Path $RepoHashPath -value "`"$RepoName`","
	}
	Add-Content -Path $RepoHashPath -value ")"

}

function Render-RepoCLI {
	$RepoHash = @{}
	$RepoNames = @()
	. $RepoHashPath
	Set-Content -Path $RepoCLIPath -Value "param ("
	Add-Content -Path $RepoCLIPath -Value "[ValidateSet("
	foreach ($RepoName in $RepoNames) {
		Add-Content -Path $RepoCLIPath -Value "`"$RepoName`","
	}
	Add-Content -Path $RepoCLIPath -Value ")]"
	Add-Content -Path $RepoCLIPath -Value '[string]$Repo = "NoRepoProvided"'
	Add-Content -Path $RepoCLIPath -Value ")"
	Add-Content -Path $RepoCLIPath -Value "try {"
	Add-Content -Path $RepoCLIPath -Value 'Write-Host "Repo: $Repo"'
	Add-Content -Path $RepoCLIPath -Value '$repos = @{'
	foreach ($Repo in $RepoHash.GetEnumerator()) {
		Add-Content -Path $RepoCLIPath -Value "`"$($Repo.Key)`" = `"$($Repo.Value)`""
	}
	Add-Content -Path $RepoCLIPath -Value '"Default" = ""'
	Add-Content -Path $RepoCLIPath -Value "}"
	Add-Content -Path $RepoCLIPath -Value 'if ($repos.ContainsKey($Repo)) {'
	Add-Content -Path $RepoCLIPath -Value 'code-insiders $repos[$Repo]'
	Add-Content -Path $RepoCLIPath -Value "} else {"
	Add-Content -Path $RepoCLIPath -Value 'code-insiders'
	Add-Content -Path $RepoCLIPath -Value "}"
	Add-Content -Path $RepoCLIPath -Value "}"
	Add-Content -Path $RepoCLIPath -Value "catch {"
	Add-Content -Path $RepoCLIPath -Value 'Write-Host "Error: $($_.Exception.Message)"'
	Add-Content -Path $RepoCLIPath -Value "}"
}
function Comprobar {
	$Nombre = Read-Host "¿Cómo te llamas?"
	Write-Host "Hola $Nombre"
}
function AddGitBashBin {
	$env:Path += ";C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin"
	Write-Host "Git Bash agregado al Path"
}
