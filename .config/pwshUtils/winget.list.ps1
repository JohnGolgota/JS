. $env:JS\.config\pwshUtils\Applications.Repository.ps1
$DATA_SOURCE = ".\.data\main.db"
$Applications = New-Object Applications
$Applications_names = $Applications.getApplications()
$applicationsRepository = New-Object ApplicationsRepository -ArgumentList $DATA_SOURCE, $Applications_names

$current_winget_path = ".\temp.json"
if (-not (Test-Path $current_winget_path)) {
	winget export -o $current_winget_path
}

$winget_list = Get-Content $current_winget_path | ConvertFrom-Json
$winget_list.Sources.Packages | ForEach-Object {
	# $AplicationsList = $applicationsRepository.GetByParam(@{id = "%$($_.PackageIdentifier)%"}, $true)
	$query = "SELECT * FROM Applications WHERE id LIKE '%$($_.PackageIdentifier)%' AND attr_source = 1"
	$AplicationsList = Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
	if ($AplicationsList) {
		# write-host "if $($_.PackageIdentifier)"
		$query = "UPDATE Applications SET installed = 1 WHERE id LIKE '%$($_.PackageIdentifier)%' AND attr_source = 1 AND i_use_that = 1"
		Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
		return
	}
	$query = "INSERT INTO Applications (id, name, attr_source, i_use_that, installed) VALUES ('$($_.PackageIdentifier)', '$($_.PackageIdentifier)', 1, 2, 1)"
	Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
}

$query = 'SELECT * FROM Applications WHERE installed = 0 AND attr_source = 1 AND i_use_that = 1'
$AplicationsList = Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
if ($AplicationsList) {
	$AplicationsList | ForEach-Object {
		Write-Host "winget install --id $_ -e --source winget"
		# winget install --id $_ -e --source winget
	}
}
