# Set the parameters
$SourceTreeDownloadUrl = "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-3.4.12.exe"
$InstallPath = "C:\Program Files\SourceTree\"

# Download the SourceTree installer
Invoke-WebRequest -Uri $SourceTreeDownloadUrl -OutFile "$env:TEMP\SourceTreeSetup.exe"

# Start the installer and wait for it to finish
$installerProcess = Start-Process -FilePath "$env:TEMP\SourceTreeSetup.exe" -ArgumentList "/S" -PassThru
while (-not $installerProcess.HasExited -and (-not (Get-Process -Id $installerProcess.Id -ErrorAction SilentlyContinue))) {
    Start-Sleep -Seconds 1
}