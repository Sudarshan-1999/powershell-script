$remoteComputerName = "172.18.1.189"
$remoteComputerName1= "D102034"
$username = ".\admin"
# $username1 = "admin"
$password = ConvertTo-SecureString "******" -AsPlainText -Force
# $password1 = ConvertTo-SecureString "********" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)
# $credential1 = New-Object System.Management.Automation.PSCredential($username1, $password1)
$sourcePath = "D:\ansible-test\"
# $sourcePath = "D:\"
$destinationPaths = @(
    "\\172.18.1.189\D$\test-sync"
)
$logfile = "D:\rcc_build\sendfiles_logs1.txt"

# Function to synchronize files using PS session and log the activity
function Sync-Files {
    param (
        [string]$Source,
        [string[]]$Destinations
    )
    # Get all files in the source directory
$files = Get-ChildItem -Path $Source -Recurse
    
foreach ($file in $files) {
    foreach ($destination in $Destinations) {
		
		$session = New-PSSession -ComputerName $remoteComputerName -Credential $credential
		# $session1 = New-PSSession -ComputerName $remoteComputerName1 -Credential $credential1
        #Invoke-Command -Session $session -ScriptBlock $scriptBlock -ArgumentList $source, $destination
		$sourceFile = Join-Path -Path $Source -ChildPath $destination.Name
		if (-not (Test-Path -Path $sourceFile)) {

            # The file does not exist in the source path, so copy it from the destination path.
            Remove-Item -Path $file -Force
			# Print the file copied to destination.
			Write-Host "File delete to destination: $file"
        }
        else {

            # The file exists in the source path, so it will be overwritten.
            Copy-Item -Path $Source -Destination $destination -Force -Recurse
			Write-Host "File overwritten: $destination $file"
        }
		
		Remove-PSSession $session		
		}
	}
}

# Initial sync
Sync-Files -Source $sourcePath -Destinations $destinationPaths

# Monitor changes and sync periodically (example: every 10 minutes)
while ($true) {
    # Wait for 10 minutes
    Start-Sleep -Seconds 10

    # Sync files
    Sync-Files -Source $sourcePath -Destinations $destinationPaths
}
