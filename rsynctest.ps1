$sourcePath = "D:\ansible-test"
$remoteDestinationIP = "172.18.1.189"
$remoteUsername = "admin"
$remotePassword = "People_123$%"
$remotePath = "D:\test-sync"

# Sync files from source to remote destination using Rsync over SSH
rsync -avz -e "sshpass -p $remotePassword ssh -o StrictHostKeyChecking=no" 'D:\ansible-test'  admin@172.18.1.189:/