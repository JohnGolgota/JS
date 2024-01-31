. $env:JS/bin\pwshModuls\Alias_enum.ps1 #Alias

Write-Host "Creating Bash profile"
New-Item ~/.bash_aliases -Type File -Force -ErrorAction SilentlyContinue

$Alias.GetEnumerator() | ForEach-Object {
	$name = $_.Name
	$value = $_.Value
	Add-Content -Path ~/.bash_aliases -Value "alias $name=$value"
}


New-Item ~/.bashrc -Type File -Force -ErrorAction SilentlyContinue
Add-Content -Path ~/.bashrc -Value "source ~/.bash_aliases"