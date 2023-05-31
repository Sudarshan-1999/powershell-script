# Import-Module TaskScheduler $task = New-Task
# $task.Settings.Hidden = $true
# Add-TaskAction -Task $task -Path C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe –Arguments "-File D:\dtest\daily_setup_repo.ps1"
# Add-TaskTrigger -Task $task -Daily -At "13:15"
# Register-ScheduledJob –Name "Daily Setup" -Task $task

$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -File "D:\dtest\daily_setup_repo.ps1" >> "D:\dtest\log.txt"'
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 15:38
$taskSettings = New-ScheduledTaskSettingsSet
Register-ScheduledTask -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings -TaskName "DailyScriptTask1" -Description "Runs the script daily at 14:47"