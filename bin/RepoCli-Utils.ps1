$MyPaths = $env:MY_PATHS -split ";"

$RepoHashPath = $MyPaths[0]
$RepoCLIPath = $MyPaths[1]

function Test-RepoCLIDependencies {
    if (-not(Test-Path $RepoHashPath)) {
        Write-Host "Creando archivo $RepoHashPath"
        New-Item -Path $RepoHashPath -ErrorAction SilentlyContinue
    }
    if (-not(Test-Path $RepoCLIPath)) {
        Write-Host "Creando archivo $RepoCLIPath"
        New-Item -Path $RepoCLIPath -ErrorAction SilentlyContinue
    }
}

function Write-RepoCLIParams {
    param (
        [Parameter(Mandatory = $true)]
        [hashtable]$RepoHash
    )
    try {
        Test-RepoCLIDependencies

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
        Test-RepoCLIDependencies

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

        [string]$NewRepoPath = (Get-Location).Path
    )
    try {
        Test-RepoCLIDependencies

        $RepoHash = @{}
        . $RepoHashPath
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
        Test-RepoCLIDependencies

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
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$RepoToEdit,

        [Parameter()]
        [string]$NewRepoPath,

        [Parameter()]
        [string]$NewName,

        [switch]$OnlyName = $false
    )
    try {
        Test-RepoCLIDependencies

        $RepoHash = @{}
        . $RepoHashPath
        Write-Host "RepoToEdit: $RepoToEdit"


        Write-Host "Confirmación de parámetros: NewRepoPath: $NewRepoPath, NewName: $NewName, OnlyName: $OnlyName"
        if (-not $RepoHash.ContainsKey($RepoToEdit)) {
            throw "El repositorio '$RepoToEdit' no existe, no se puede editar. Las opciones válidas son: $($RepoHash.Keys -join ', ')"
        }
        Write-Host "El repositorio '$RepoToEdit' existe"
        if ($NewRepoPath -eq "" -or $null -eq $NewRepoPath) {
            $NewRepoPath = $RepoHash[$RepoToEdit]
            Write-Host "No se ha proporcionado un nuevo directorio para el repositorio, se usará el actual"
        }
        if (-not (Test-Path $NewRepoPath)) {
            throw "El directorio '$NewRepoPath' no existe"
        }
        Write-Host "El directorio '$NewRepoPath' existe"

        if ($NewName -ne "" -and $OnlyName -eq $true) {
            Write-Host "Se ha proporcionado un nuevo nombre para el repositorio"
            $RepoHash.Add($NewName, $RepoHash[$RepoToEdit])
            $RepoHash.Remove($RepoToEdit)
        }
        elseif ($NewName -ne "" -and $OnlyName -eq $false) {
            Write-Host "Se ha proporcionado un nuevo nombre y un nuevo directorio para el repositorio"
            $RepoHash.Remove($RepoToEdit)
            $RepoHash.Add($NewName, $NewRepoPath)
        }
        else {
            Write-Host "Se ha proporcionado un nuevo directorio para el repositorio"
            $RepoHash[$RepoToEdit] = $NewRepoPath
        }

        Write-RepoCLIParams -RepoHash $RepoHash
        Build-RepoCLI
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }

}
function Build-RepoCLI {
    Test-RepoCLIDependencies

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
            cd `$repos[`$Repo]
        } else {
           throw "El Repositorio `$Repo No existe."
        }
    }
    catch {
        Write-Host "Error: `$(`$_.Exception.Message)"
    }
"@
}