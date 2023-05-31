$remoteComputerName = "172.18.1.189"

$username = ".\admin"

$password = ConvertTo-SecureString "People_123$%" -AsPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Get the source and destination paths.
$sourcePath = "D:\ansible-test"
$destinationPath = "\\172.18.1.189\D$\test-sync"

# Create a remote session to the destination computer.
$session = New-PSSession -ComputerName $remoteComputerName -Credential $credential

# Get the list of files in the destination path.
$destinationFiles = Get-ChildItem -Path $destinationPath

# Loop through the list of files in the destination path.
foreach ($destinationFile in $destinationFiles) {

    # Check if the file exists in the source path.
    $sourceFile = Join-Path -Path $sourcePath -ChildPath $destinationFile.Name -Recurse
    if (-not (Test-Path -Path $sourceFile)) {

        # The file does not exist in the source path, so copy it from the destination path.
        Copy-Item -Path $destinationFile -Destination $sourceFile -Session $session

        # Print the file copied to destination.
        Write-Host "File copied to destination: $destinationFile"
    }
    else {

        # The file exists in the source path, so it will be overwritten.
        Copy-Item -Path $destinationFile -Destination $sourceFile -Session $session

        # Print the file which is overwritten.
        Write-Host "File overwritten: $destinationFile"
    }
}

# Close the remote session.
Remove-PSSession $session
# Define the function.
function Sync-Directory() {

    # Get the source and destination paths.
    $sourcePath = "C:\source\folder"
    $destinationPath = "\\\remote\computer\destination\folder"

    # Create a remote session to the destination computer.
    $session = New-PSSession -ComputerName remotecomputer

    # Get the list of files in the destination path.
    $destinationFiles = Get-ChildItem -Path $destinationPath

    # Loop through the list of files in the destination path.
    foreach ($destinationFile in $destinationFiles) {

        # Check if the file exists in the source path.
        $sourceFile = Join-Path -Path $sourcePath -ChildPath $destinationFile.Name
        if (-not (Test-Path -Path $sourceFile)) {

            # The file does not exist in the source path, so copy it from the destination path.
            Copy-Item -Path $destinationFile -Destination $sourceFile -Session $session
			# Print the file copied to destination.
			Write-Host "File copied to destination: $destinationFile"
        }
        else {

            # The file exists in the source path, so it will be overwritten.
            Copy-Item -Path $destinationFile -Destination $sourceFile -Session $session
			Write-Host "File overwritten: $destinationFile"
        }
    }

    # Close the remote session.
    Remove-PSSession $session
}