# Description: Test script for VS Code
# Soy increible... documentar? que es eso?

$MyPaths = $env:MY_PATHS -split ";"
$RepoHashPath = $MyPaths[0]
$RepoCLIPath = $MyPaths[1]

Set-Variable -Name "splitedEnv" -Value $env:Path.Split(";")
function Write-RepoCLIParams {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$RepoHash
    )
    try {
        $RepoNames = @()
        Set-Content -Path $RepoHashPath -Value '$RepoHash = @{'
        foreach ($Repo in $RepoHash.GetEnumerator()) {
            Add-Content -Path $RepoHashPath -value "`"$($Repo.Key)`"=`"$($Repo.Value)`""
            # array from hashtable keys
            $RepoNames += $Repo.Key
        }
        Add-Content -Path $RepoHashPath -value "}"
    
        $RepoNamesJoin = $RepoNames -join "','"
        Add-Content -Path $RepoHashPath -value $('$RepoNames = @(' + "'$RepoNamesJoin'" + ')')
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}
function Remove-ToRepoCLI {
    param (
        [Parameter(Mandatory = $true)]
        [string]$RepoToRemove
    )
    try {
        $RepoHash = @{}
        . $RepoHashPath
        $RepoHash.Remove($RepoToRemove)
        Write-RepoCLIParams -RepoHash $RepoHash
        Build-RepoCLI
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}
function Add-ToRepoCLI {
    param (
        [Parameter(Mandatory = $true)]
        [string]$NewRepoName,

        [Parameter(Mandatory = $true)]
        [string]$NewRepoPath,

        [bool]$Force = $false
    )
    try {
        $RepoHash = @{}
        if ($Force -eq $false) {
            . $RepoHashPath
        }
        # TODO validate if repo exists
        $RepoHash.Add($NewRepoName, $NewRepoPath)
        Write-RepoCLIParams -RepoHash $RepoHash
        Build-RepoCLI
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}
function Get-RepoCLI {
    try {
        $RepoHash = @{}
        . $RepoHashPath
        $RepoHash.GetEnumerator()
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }    
}
function Edit-RepoCLI {
    param (
        [Parameter(Mandatory = $true)]
        [string]$RepoToEdit,

        [Parameter(Mandatory = $true)]
        [string]$NewRepoPath
    )
    $RepoHash = @{}
    . $RepoHashPath

    $RepoHash[$RepoToEdit] = $NewRepoPath

    Write-RepoCLIParams -RepoHash $RepoHash
    Build-RepoCLI

}

function Build-RepoCLI {
    $RepoHash = @{}
    $RepoNames = @()
    . $RepoHashPath
    $RepoNames = $RepoNames -join "','"
    Set-Content -Path $RepoCLIPath -Value @"
    param (
        [ValidateSet('$RepoNames')]
        [string]`$Repo = "NoRepoProvided"
    )
    try {
        Write-Host "Repo: `$Repo"

        `$repos = @{
"@
    foreach ($Repo in $RepoHash.GetEnumerator()) {
        Add-Content -Path $RepoCLIPath -Value "`"$($Repo.Key)`" = `"$($Repo.Value)`""
    }
    Add-Content -Path $RepoCLIPath -Value @"
        }
        if (`$repos.ContainsKey(`$Repo)) {
            code-insiders `$repos[`$Repo]
        } else {
            code-insiders
        }
    }
    catch {
        Write-Host "Error: `$(`$_.Exception.Message)"
    }
"@
}

function Comprobar {
    $Nombre = Read-Host "¿Cómo te llamas?"
    Write-Host "Hola $Nombre"
}
function AddGitBashBin {
    $env:Path += ";C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin"
    Write-Host "Git Bash agregado al Path"
}
function Set-CustomMain {
    try {
        Set-Alias -Name x -Value nvim -Option AllScope -Scope Global
        Write-Host "Custom-Main"
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}