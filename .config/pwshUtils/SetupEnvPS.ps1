param (
	# Ruta al archivo de entorno
	[Parameter(Mandatory = $true)]
	[string]$PathEnvFile
)
try {
	# Contenido del archivo de entorno
	$ContentEnv = Get-Content -Path $PathEnvFile

	# Iterar sobre cada línea del archivo de entorno
	$ContentEnv | ForEach-Object {
		# Separar la línea en nombre y valor usando el signo igual
		$Name, $Value = $_.Split("=")

		# Limpiar el valor eliminando espacios alrededor
		$Value = $Value.Trim()

		# Debug (descomentar para depuración)
		# Write-Host "Name: $($Name) Value: $($Value)"

		if ($Value -eq "") {
			Write-Host "Skip: $Name Value: $Value"
			continue
		}

		# Establecer la variable de entorno de forma persistente a nivel de usuario
		[System.Environment]::SetEnvironmentVariable($Name, $Value, "User")
		Write-Host "Set: $Name Value: $Value"
	}

	if ($null -ne $env:JS -and $env:JS -ne "") {
		# Agregar la ruta al directorio JS al Path
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
