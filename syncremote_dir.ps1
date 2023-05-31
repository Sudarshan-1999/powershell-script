$remoteComputerName = "172.18.1.189"
$username = ".\Admin"
$password = ConvertTo-SecureString "********" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

$sourcePath = "D:\ansible-test"
$destinationPaths = @(
    "\\172.18.1.189\D$\test-sync"
)
$logfile = "D:\rcc_build\sendfiles_logs1.txt"

# Function to copy files and log the activity
function Sync-Files {
    param (
        [string]$Source,
        [string[]]$Destinations
    )
    
    # Get all files in the source directory
    $files = Get-ChildItem -Path $Source -Recurse
    
    foreach ($file in $files) {
        foreach ($destination in $Destinations) {
            # Copy the file to the destination
            # Optional: Define any additional Robocopy options you want to use /PURGE
			$robocopyOptions = "/MIR /Z /FFT /W:5 /R:2"

			# Invoke Robocopy to sync the directories and files
			Start-Process -FilePath "robocopy.exe" -ArgumentList "`"$Source`" `"$destination`" $robocopyOptions" -Wait

        }
    }
}

# Initial sync
Sync-Files -Source $sourcePath -Destinations $destinationPaths

# Monitor changes and sync periodically (example: every 10 minutes)
while ($true) {
    # Wait for 10 minutes
    Start-Sleep -Seconds 600
    
    # Sync files
    Sync-Files -Source $sourcePath -Destinations $destinationPaths
}
