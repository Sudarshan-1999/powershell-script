$selectedDirectory = ""
$daysThreshold = 14  # Number of days for the threshold

$thresholdDate = (Get-Date).AddDays(-$daysThreshold)

# Get all files and directories in the selected directory
$items = Get-ChildItem -Path $selectedDirectory -Recurse

# Filter items based on the modified date
$itemsToDelete = $items | Where-Object { $_.LastWriteTime -lt $thresholdDate }

# Delete files
$filesToDelete = $itemsToDelete | Where-Object { -not $_.PSIsContainer }
$filesToDelete | Remove-Item -Force

# Delete directories
$directoriesToDelete = $itemsToDelete | Where-Object { $_.PSIsContainer }
$directoriesToDelete | Remove-Item -Recurse -Force