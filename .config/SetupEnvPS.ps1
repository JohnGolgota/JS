try {
	# environment file
	$PathEnvFile = ".env"

	# Content
	$ContentEnv = Get-Content -Path $PathEnvFile

	# Iterate
	$ContentEnv | ForEach-Object {
		# Split
		$Name, $Value = $_.Split("=")

		# Trim
		$Value = $Value.Trim()

		# Debug
		# Write-Host "Name: $($Name) Value: $($Value)"
		if ($Value -eq "") {
			Write-Host "Skip: $Name Value: $Value"
			continue
		}
		[System.Environment]::SetEnvironmentVariable($Name, $Value, "User")
		Write-Host "Set: $Name Value: $Value"
	}
	if ($null -ne $env:JS -and $env:JS -ne "") {
		[System.Environment]::SetEnvironmentVariable("Path", "$env:JS/.bin;$env:Path", "User")
		Write-Host "Done"
		exit 0
	}
	else {
		Write-Host "Error: JS environment variable not found"
		exit 1
	}
}
catch {
	Write-Host "Error: $($_.Exception.Message)"
	exit 1
}