$remoteComputerName = "172.18.1.189"
$username = ".\Admin"
$password = ConvertTo-SecureString "People_123$%" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Get the source and destination paths.
$sourcePath = "D:\ansible-test\"
$destinationPath = "\\172.18.1.189\D$\test-sync"

# Create a remote session to the destination computer.
# $session = New-PSSession -ComputerName $remoteComputerName -Credential $credential

# Get the list of files in the destination path.
$destinationFiles = Get-ChildItem -Path $destinationPath

# Loop through the list of files in the destination path.
foreach ($destinationFile in $destinationFiles) {

    # Check if the file exists in the source path.
	$session = New-PSSession -ComputerName $remoteComputerName -Credential $credential
    $sourceFile = Join-Path -Path $sourcePath -ChildPath $destinationFile.Name
    if (-not (Test-Path -Path $sourceFile)) {

        # The file does not exist in the source path, so delete it from the destination path.
        # Remove-Item -Path $destinationFile -Session $session
		Remove-Item -Path $destinationFile -Recurse -Force -WhatIf
		
		Remove-PSSession $session
    }
}

# Close the remote session.
# Remove-PSSession $session