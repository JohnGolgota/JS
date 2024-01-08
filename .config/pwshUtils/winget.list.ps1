# Esto existe por si falla el import de winget
$AplicationsList = @(
	# "Git.Git"
	# Tools
	"GitHub.GitHubDesktop"
	"Docker.DockerDesktop"
	"dbeaver.dbeaver"
	"Insomnia.Insomnia"
	"Microsoft.XNARedist"
	# Console Emulators
	"Microsoft.WindowsTerminal"
	"Mobatek.MobaXterm"
	# Cli
	"Microsoft.PowerShell"
	"GitHub.cli"
	# Editores de texto y IDEs
	"Microsoft.VisualStudioCode.Insiders"
	"Microsoft.VisualStudioCode"
	"Neovim.Neovim"
	"Google.AndroidStudio"
	# Lenguajes de programación
	"CoreyButler.NVMforWindows"
	"Python.Python.3.11"
	"Rustlang.Rustup"
	"GoLang.Go"
	"zig.zig"
	"rjpcomputing.luaforwindows"
	"Oracle.JavaRuntimeEnvironment"
	"RubyInstallerTeam.Ruby.3.1"
	# SDKs
	"Microsoft.WindowsSDK.10.0.22000"
	"Oracle.JDK.18"
	# Design y multimedia
	"OBSProject.OBSStudio"
	"GIMP.GIMP"
	"Microsoft.PowerToys"
	# Navegadores
	"Mozilla.Firefox.DeveloperEdition"
	# Games
	"Valve.Steam"
	# Remote
	"GlavSoft.TightVNC"
	"AnyDeskSoftwareGmbH.AnyDesk"
	# Social
	"Discord.Discord"
	"Telegram.TelegramDesktop"
	# Cloud
	"Microsoft.OneDrive"
	# Visual Studio
	"Microsoft.VCRedist.2015+.x64"
	"Microsoft.VisualStudio.2022.Community"
	"Microsoft.VisualStudio.2022.BuildTools"
	# Security
	"Twilio.Authy"
	"RonyShapiro.PasswordSafe"
	# Opcional
	"Highresolution.X-MouseButtonControl"
	"Logitech.OptionsPlus"
	"Kingston.SSDManager"
	# productivity and office
	"AnyAssociation.Anytype"
	"Logseq.Logseq"
)

$AplicationsList | ForEach-Object {
	Write-Host "winget install --id $_ -e --source winget"
	winget install --id $_ -e --source winget
}