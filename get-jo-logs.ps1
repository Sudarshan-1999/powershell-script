$a_sb = {
	Write-Output "Hello A"
	Start-Sleep -Seconds 10
	Write-Output "Goodbye A"
}

$b_sb = {
	Write-Output "Hello B"
	Start-Sleep -Seconds 5
	Write-Output "Goodbye B"
}

$job = Start-Job -Scriptblock $a_sb
$a_log = $job.Name

$job = Start-Job -Scriptblock $b_sb
$b_log = $job.Name

$Completed = $false

while (!$Completed) {

	$jobs = Get-Job | Where-Object {$_.State.ToString() -ne "Completed"}
	if ($null -eq $jobs) {
		$Completed=$true
	}
	else {
		Write-Output "Waiting for $($jobs.Count) jobs"
	}
	
	Start-Sleep -s 1
	
}

Get-Job | Where-Object {$_.Name -eq $a_log} | Receive-Job | Out-File .\a.log
Get-Job | Where-Object {$_.Name -eq $b_log} | Receive-Job | Out-File .\b.log