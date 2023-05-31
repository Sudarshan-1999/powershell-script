$sourcePath = "D:\ansible-test"
$destinationPath = "\\172.18.1.189\test-sync"

# Optional: Define any additional Robocopy options you want to use
$robocopyOptions = "/MIR /Z /FFT /W:5 /R:2 /PURGE"

# Invoke Robocopy to sync the directories and files
Start-Process -FilePath "robocopy.exe" -ArgumentList "`"$sourcePath`" `"$destinationPath`" $robocopyOptions" -Wait