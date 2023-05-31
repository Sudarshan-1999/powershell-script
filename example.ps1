$installerPath = "C:\Users\SudarshanRamdasDamah\Downloads\qt-unified-windows-x64-4.5.2-online.exe"
$components = "qt.tools.win64_msvc2019", "qt.qt5.15.2.win64_msvc2019_64"

# Set the options for the installer
$options = "--download=all --accept-licenses --silent --script D:\dtest\qt-script.qs --install-dir C:\Qt $components"

# Launch the Qt installer with the specified options
Start-Process $installerPath -ArgumentList $options -Wait


var installer = new QInstaller();
installer.setDefaultPageVisible(QInstaller.TargetDirectory, false);
installer.setDefaultPageVisible(QInstaller.ComponentSelection, true);
var componentSelection = installer.componentSelection();
componentSelection.selectAll();
componentSelection.deselectComponent("qt.tools");
componentSelection.deselectComponent("qt.qtwebengine");
componentSelection.deselectComponent("qt.qtwebview");
componentSelection.deselectComponent("qt.qtwayland");
componentSelection.deselectComponent("qt.qt3d");
installer.install();



# Set the registry keys for SourceTree and Bitbucket Server
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree" -Name "UserEmail" -Value "sudarshan.damahe@rampgroup.com" -PropertyType String -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree" -Name "UserName" -Value "sudarshan.damahe" -PropertyType String -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree" -Name "UseSystemGit" -Value "False" -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree\Git" -Name "UseCredentialManager" -Value "True" -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree\Profiles\Bitbucket" -Name "BaseUrl" -Value "https://bitbucket.rampgroup.com" -PropertyType String -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree\Accounts\Bitbucket" -Name "Username" -Value "sudarshan.damahe@rampgroup.com" -PropertyType String -Force
New-ItemProperty -Path "HKCU:\Software\Atlassian\SourceTree\Accounts\Bitbucket" -Name "Password" -Value "Sumo@1999" -PropertyType String -Force


$sourceTreeUrl = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-3.4.12.exe"
$installerPath = "$env:TEMP\SourceTreeSetup-3.4.12.exe"

# Download SourceTree installer
Invoke-WebRequest -Uri $sourceTreeUrl -OutFile $installerPath

# Install SourceTree
Start-Process -FilePath $installerPath -ArgumentList "/SILENT" -Wait

# Configure SourceTree with Bitbucket Server credentials
$registryKeyPath = "HKCU:\Software\Atlassian\SourceTree"
$emailAddress = "sudarshan.damahe@rampgroup.com"
$serverUrl = "https://bitbucket.rampgroup.com"

New-ItemProperty -Path $registryKeyPath -Name "UserEmail" -Value $emailAddress -Force | Out-Null
New-ItemProperty -Path $registryKeyPath -Name "ServerUrl" -Value $serverUrl -Force | Out-Null






