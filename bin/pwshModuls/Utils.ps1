function Get-LogCustom {
    param(
        [Parameter(Mandatory = $true)]
        [string]$message,
        [Parameter(Mandatory = $false)]
        [string]$type = "INFO"
    )
    $dateString = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
    $log = "$dateString - $type - $message"
    Write-Host $log
    Add-Content -Path $LogsPath -Value $log
}

function AddGitBashBin {
    $env:Path += ";C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin"
    Write-Host "Git Bash agregado al Path"
}

function Import-CustomModules {
    try {
        Import-Module $env:JS\bin\pwshModuls\CustomUserUtils.psm1
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}