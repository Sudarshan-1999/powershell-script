$installerPath = "C:\Users\SudarshanRamdasDamah\Downloads\qt-unified-windows-x64-4.5.2-online.exe"

# Launch the Qt installer
Start-Process $installerPath -ArgumentList "--verbose" -Wait

# Find the installer object and select the desired components
$installer = Get-Process | Where-Object {$_.ProcessName -eq "qt-unified-windows-x86-4.0.1-online"}
$installer.setDefaultPageVisible($installer.ComponentSelection, $false)
$installer.ComponentSelectAll.setChecked($false)
$installer.ComponentByName("qt.6.2.2.win64_msvc2019_64").setChecked($true)
$installer.ComponentByName("qt.tools.win64_msvc2019_64").setChecked($true)
$installer.setDefaultPageVisible($installer.ComponentSelection, $true)
$installer.ComponentSelectAll.setChecked($true)
$installer.ComponentNextButton.click()

# Accept the license agreement and install Qt
$installer.setDefaultPageVisible($installer.LicenseAgreement, $false)
$installer.AcceptLicenseRadioButton.click()
$installer.setDefaultPageVisible($installer.LicenseAgreement, $true)
$installer.NextButton.click()
$installer.setDefaultPageVisible($installer.ReadyForInstallation, $false)
$installer.installButton.click()

# Wait for the installation to complete and close the installer
$installer.WaitForInputIdle()
Start-Sleep -Seconds 10
$installer.CloseMainWindow()