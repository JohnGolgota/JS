function Comprobar {
	$Nombre = Read-Host "¿Cómo te llamas?"
	Write-Host "Hola $Nombre"
}
function AddGitBashBin {
	$env:Path += ";C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin"
	Write-Host "Git Bash agregado al Path"
}
