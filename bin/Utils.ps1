function Get-LogCustom {
    param(
        [Parameter(Mandatory=$true)]
        [string]$message,
        [Parameter(Mandatory=$false)]
        [string]$type = "INFO"
    )
    $dateString = Get-Date -Format "dd-MM-yyyy HH:mm:ss"
    $log = "$dateString - $type - $message"
    Write-Host $log
    Add-Content -Path "C:\JS\test\log.txt" -Value $log
}