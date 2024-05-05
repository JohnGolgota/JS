Import-Module -Name PSSQLite

$current_winget_path = ".\temp.json"
if (-not (Test-Path $current_winget_path)) {
	winget export -o $current_winget_path
}

$winget_list = Get-Content $current_winget_path | ConvertFrom-Json
$winget_list.Sources.Packages | ForEach-Object {
	$query = "SELECT * FROM Applications WHERE id LIKE '%$($_.PackageIdentifier)%' AND source = 1"
	$AplicationsList = Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
	if ($AplicationsList) {
		write-host "if $($_.PackageIdentifier)"
		return
	}
	$query = "INSERT INTO Applications (id, name, source, i_use_that) VALUES ('$($_.PackageIdentifier)', '$($_.PackageIdentifier)', 1, 2)"
	Invoke-SqliteQuery -DataSource ".\.data\main.db" -Query $query
}

$query = "SELECT * FROM Applications WHERE install = 1 AND 'source' = 1"

# $AplicationsList | ForEach-Object {
# 	Write-Host "winget install --id $_ -e --source winget"
# 	# winget install --id $_ -e --source winget
# }