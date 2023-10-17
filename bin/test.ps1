try {   
    $dateString = Get-Date -Format "yyyy-MM-dd"
    $resultDir = "$testdir\test-results\$dateString"
    $toBackupDir = "$testdir\backup"
    # make a directory for the test results
    if (-not (Test-Path $resultDir)) {
        New-Item -ItemType Directory -Path $resultDir
        Write-Host "Created directory $resultDir"
    }
    else {
        Write-Host "Directory $resultDir already exists"
    }
    # copy the files to backup to the test results directory
    Write-Host "Copying files from $toBackupDir to $resultDir"
    Copy-Item -Path "$toBackupDir\*" -Destination $resultDir -Recurse -Force
    Write-Host "Done"
}
catch {
    <#Do this if a terminating exception happens#>
    Write-Host "Error: $_"
}
