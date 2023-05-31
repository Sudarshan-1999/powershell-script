$remoteComputerName = "172.18.1.189"
$username = ".\Admin"
$password = ConvertTo-SecureString "People_123$%" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)
Enter-PSSession -ComputerName $remoteComputerName -Credential $credential


$sourcePath = "D:\ansible-test"
$destinationPath = "\\172.18.1.189\D$\test-sync"
$logfile = "D:\rcc_build\sendfiles_logs.txt"

# Function to copy files and log the activity
function Sync-Files {
    param (
        [string]$Source,
        [string]$Destination
    )
    
    # Get all files in the source directory
    $files = Get-ChildItem -Path $Source -File -Recurse
    
    foreach ($file in $files) {
        $destinationFile = Join-Path -Path $Destination -ChildPath $file.FullName.Substring($Source.Length)
        
        # Copy the file to the destination
        Copy-Item -Path $file.FullName -Destination $destinationFile -Force
        
        # Log the copied file
        Add-Content -Path $logfile -Value "Copied: $($file.FullName) --> $($destinationFile)"
    }
}

# Initial sync
Sync-Files -Source $sourcePath -Destination $destinationPath

# Monitor changes and sync periodically (example: every 10 minutes)
while ($true) {
    # Wait for 10 minutes
    Start-Sleep -Seconds 600
    
    # Sync files
    Sync-Files -Source $sourcePath -Destination $destinationPath
}