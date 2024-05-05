. $env:JS\.config\pwshUtils\windows-setPersonalConfig.ps1

# Pwsh Extra Config
Install-MyPSModules
# Install Apps
Install-WingetAll
Install-ScoopPersonal
# Shell Config
Set-SecondConfig
# Apps Config
Set-NvimPersonalConfig
Set-fnmPersonalSetup
Set-PersonalSetupWSL