# Define the list of malicious indicators (e.g., file hashes, suspicious processes, IPs)
$maliciousHashes = @("abc123...", "def456...")  # Add known malicious hashes here
$maliciousProcesses = @("malware.exe", "suspicious.exe", "notepad.exe")  # Add known malicious process names
$maliciousIPs = @("192.168.1.100", "203.0.113.45")  # Add known malicious IP addresses

# Define the email settings for notifications
$emailFrom = "soc@domain.com"
$emailTo = "hack3rm33@gmail.com"
$emailSubject = "Automated Malware Detection Alert"
$smtpServer = "smtp.domain.com"  # Update with actual SMTP server

# Function to send email alerts
function Send-AlertEmail {
    param(
        [string]$subject,
        [string]$body
    )

    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $message = New-Object Net.Mail.MailMessage($emailFrom, $emailTo, $subject, $body)
    $smtp.Send($message)
}

# Scan for suspicious files (by hash)
function Scan-SuspiciousFiles {
    $files = Get-ChildItem -Path "C:\" -Recurse -File -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        $fileHash = Get-FileHash -Path $file.FullName -Algorithm SHA256
        if ($maliciousHashes -contains $fileHash.Hash) {
            Write-Host "Malicious file detected: $($file.FullName)"
            Send-AlertEmail -subject $emailSubject -body "Malicious file detected: $($file.FullName)"
            # You could delete or quarantine the file if desired
        }
    }
}

# Scan for suspicious processes
function Scan-SuspiciousProcesses {
    $processes = Get-Process

    foreach ($process in $processes) {
        if ($maliciousProcesses -contains $process.Name) {
            Write-Host "Malicious process detected: $($process.Name)"
            Stop-Process -Name $process.Name -Force
            Send-AlertEmail -subject $emailSubject -body "Malicious process detected: $($process.Name)"
        }
    }
}

# Scan for suspicious network connections
function Scan-SuspiciousConnections {
    $connections = Get-NetTCPConnection

    foreach ($connection in $connections) {
        if ($maliciousIPs -contains $connection.RemoteAddress) {
            Write-Host "Suspicious network connection detected: $($connection.RemoteAddress)"
            # You could block the IP or take additional action here if needed
            Send-AlertEmail -subject $emailSubject -body "Suspicious network connection detected: $($connection.RemoteAddress)"
        }
    }
}

# Main execution
Write-Host "Starting Malware Detection..."

# Perform scans
Scan-SuspiciousFiles
Scan-SuspiciousProcesses
Scan-SuspiciousConnections

Write-Host "Malware Detection completed."
