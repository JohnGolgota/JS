$dateString = Get-Date -Format "dd-MM-yyyy"
$year = Get-Date -Format "yyyy"
$mes = Get-Date -Format "MM"

$meses = @{
    "01" = "Enero"
    "02" = "Febrero"
    "03" = "Marzo"
    "04" = "Abril"
    "05" = "Mayo"
    "06" = "Junio"
    "07" = "Julio"
    "08" = "Agosto"
    "09" = "Septiembre"
    "10" = "Octubre"
    "11" = "Noviembre"
    "12" = "Diciembre"
} 

$base = ""
$dirYear = "$base\$year"
$dirMes = "$dirYear\" + $meses[$mes]
$backupDir = "$dirMes\$dateString"

try {
    if (-not (Test-Path -Path $dirYear)) {
        New-Item -Path $dirYear -ItemType Directory
    }
    if (-not (Test-Path -Path $dirMes)) {
        New-Item -Path $dirMes -ItemType Directory
    }
    if (-not (Test-Path -Path $backupDir)) {
        New-Item -Path $backupDir -ItemType Directory
    }
    Start-Transcript -Path "$backupDir\pw.log" -Append
    Write-Host "Start-Transcript"
    cmd.exe /c "initBackup.cmd '$backupDir'" | Out-File -FilePath "$backupDir\cmd.log" -Append
    Write-Host "post cmd.exe /c initBackup.cmd $backupDir"
    Stop-Transcript
}
catch {
    Start-Transcript -Path "$backupDir\pw.log" -Append
    Write-Host "Error: $_"
    Stop-Transcript
}
