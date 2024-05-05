#Region Dowload the winget-cli package
# Paths and URIs for the winget-cli package
$licence = @{
    uri  = "https://github.com/microsoft/winget-cli/releases/download/v1.7.11132/ccfd1d114c9641fc8491f3c7c179829e_License1.xml"
    path = ".\License.xml"
}

$msixbundle = @{
    uri  = "https://github.com/microsoft/winget-cli/releases/download/v1.7.11132/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    path = ".\winget.msixbundle"
}

# Dependencies
$Microsoft_VCLibs = @{
    arm64_uri = "https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx"
    x64_uri   = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    path      = ".\Microsoft.VCLibs.14.00.Desktop.appx"
    selected = $null
}
$Arquitecture = Read-Host -Prompt @"
Enter the architecture of the Microsoft VCLibs
1 : x64, 
2 : arm64

"@

$Microsoft_UI_Xaml_2_7 = @{
    uri = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.0"
    path_origin = ".\Microsoft.UI.Xaml.2.7.0.nupkg"
    zip = "Microsoft.UI.Xaml.2.7.0.zip"
    folder = ".\Microsoft.UI.Xaml.2.7.0"
    appx = $null
}

$Microsoft_VCLibs.selected = switch ($Arquitecture) {
    1 {
        $Arquitecture = "x64" 
        $Microsoft_VCLibs.x64_uri 
    }
    2 { 
        $Arquitecture = "arm64"
        $Microsoft_VCLibs.arm64_uri
    }
    Default { $Microsoft_VCLibs.x64_uri }
}

# Download the licence
Invoke-WebRequest -Uri $licence.uri -OutFile $licence.path

# Download the msixbundle
Invoke-WebRequest -Uri $msixbundle.uri -OutFile $msixbundle.path

# Download the dependencies
Invoke-WebRequest -Uri $Microsoft_UI_Xaml_2_7.uri -OutFile $Microsoft_UI_Xaml_2_7.path_origin
Rename-Item -Path $Microsoft_UI_Xaml_2_7.path_origin -NewName $Microsoft_UI_Xaml_2_7.zip
Expand-Archive -Path ".\$($Microsoft_UI_Xaml_2_7.zip)" -DestinationPath $Microsoft_UI_Xaml_2_7.folder
$Microsoft_UI_Xaml_2_7.appx = ".\Microsoft.UI.Xaml.2.7.0\tools\AppX\$($Arquitecture)\Release\Microsoft.UI.Xaml.2.7.appx"

Invoke-WebRequest -Uri $Microsoft_VCLibs.selected -OutFile $Microsoft_VCLibs.path


#Region Install the winget-cli package
# Install the dependencies
Add-AppxPackage -Path $Microsoft_VCLibs_path
# Write-Host "Add-AppxPackage -Path $($Microsoft_VCLibs.path)"
Add-AppxPackage -Path $Microsoft_UI_Xaml_2_7.appx
# Write-Host "Add-AppxPackage -Path $($Microsoft_UI_Xaml_2_7.appx)"

# Install the msixbundle
Add-AppxPackage -Path $msixbundle_path
# Write-Host "Add-AppxPackage -Path $($msixbundle.path)"

# Install the licence
Add-AppxProvisionedPackage -Online -PackagePath $msixbundle_path -LicensePath $licence_path
# Write-Host "Add-AppxProvisionedPackage -Online -PackagePath $($msixbundle.path) -LicensePath $($licence.path)"

# Clean the downloaded files
Remove-Item -Path $licence.path
Remove-Item -Path $msixbundle.path
Remove-Item -Path $Microsoft_VCLibs.path
Remove-Item -Path $Microsoft_UI_Xaml_2_7.zip -Recurse
Remove-Item -Path $Microsoft_UI_Xaml_2_7.folder -Recurse