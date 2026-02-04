# Function to get user and their IPs for each server
function Get-ServerIPInfo {
    # Get list of all local network connections (TCP & UDP)
    $connections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }

    # Create a custom object to hold results
    $serverInfo = @()

    # Loop through each connection and get the server, user, and IP
    foreach ($connection in $connections) {
        $server = $connection.OwningProcess
        $remoteIP = $connection.RemoteAddress
        $remotePort = $connection.RemotePort

        # Get process name to find out which user is logged in
        try {
            $processInfo = Get-Process -Id $connection.OwningProcess
            $processName = $processInfo.Name
        } catch {
            $processName = "Unknown"
        }

        # Check if there is any logged-in user
        $user = (Get-WmiObject -Class Win32_ComputerSystem).UserName

        # Add to results array
        $serverInfo += [PSCustomObject]@{
            Server = $processName
            User = $user
            IP = $remoteIP
        }
    }

    # Output the result
    return $serverInfo
}

# Continuous monitoring loop
while ($true) {
    # Call the function to get network connection info
    $networkInfo = Get-ServerIPInfo

    # Output the information
    $networkInfo | ForEach-Object { Write-Host "$($_.Server) : $($_.User) : $($_.IP)" }

    # Sleep for 10 seconds before checking again (adjust as needed)
    Start-Sleep -Seconds 10

    # Optionally, you can add a break condition based on user input:
    # Check if the user presses 'Ctrl+C' to break the loop
}
