$installerPath = "C:\Users\SudarshanRamdasDamah\Downloads\qt-unified-windows-x64-4.5.2-online.exe"
$email = "jenkins@rampgroup.com"
$password = "Welcome@Ramp"
$components = "qt.tools.win64_msvc2019", "qt.qt5.15.2.win64_msvc2019_64"

# Set the options for the installer
$options = "--mirror https://qt.mirror.constant.com --email $email --pw $password --accept-licenses --accept-obligations --auto-answer telemetry-question=No,AssociateCommonFiletypes=Yes --show-virtual-components $components"

# Launch the Qt installer with the specified options
Start-Process $installerPath -ArgumentList $options -Wait