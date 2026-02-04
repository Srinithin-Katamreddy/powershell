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

# Function to get Chrome browsing history
function Get-ChromeHistory {
    $chromeHistoryPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History"

    # Check if the History file exists
    if (Test-Path $chromeHistoryPath) {
        $sqliteConnection = New-Object -TypeName System.Data.SQLite.SQLiteConnection -ArgumentList "Data Source=$chromeHistoryPath;Version=3;"
        $sqliteConnection.Open()

        $cmd = $sqliteConnection.CreateCommand()
        $cmd.CommandText = "SELECT url, title, last_visit_time FROM urls ORDER BY last_visit_time DESC LIMIT 10"
        $reader = $cmd.ExecuteReader()

        # Output the last 10 visited URLs
        $chromeHistory = @()
        while ($reader.Read()) {
            $chromeHistory += [PSCustomObject]@{
                URL = $reader["url"]
                Title = $reader["title"]
                LastVisitTime = [datetime]::FromFileTime($reader["last_visit_time"])
            }
        }

        $sqliteConnection.Close()

        return $chromeHistory
    } else {
        Write-Host "Chrome History file not found!"
        return @()
    }
}

# Function to get Edge browsing history
function Get-EdgeHistory {
    $edgeHistoryPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History"

    # Check if the History file exists
    if (Test-Path $edgeHistoryPath) {
        $sqliteConnection = New-Object -TypeName System.Data.SQLite.SQLiteConnection -ArgumentList "Data Source=$edgeHistoryPath;Version=3;"
        $sqliteConnection.Open()

        $cmd = $sqliteConnection.CreateCommand()
        $cmd.CommandText = "SELECT url, title, last_visit_time FROM urls ORDER BY last_visit_time DESC LIMIT 10"
        $reader = $cmd.ExecuteReader()

        # Output the last 10 visited URLs
        $edgeHistory = @()
        while ($reader.Read()) {
            $edgeHistory += [PSCustomObject]@{
                URL = $reader["url"]
                Title = $reader["title"]
                LastVisitTime = [datetime]::FromFileTime($reader["last_visit_time"])
            }
        }

        $sqliteConnection.Close()

        return $edgeHistory
    } else {
        Write-Host "Edge History file not found!"
        return @()
    }
}

# Continuous monitoring loop
while ($true) {
    Write-Host "Fetching Network Connections and Browsing History..."
    
    # Call the function to get network connection info
    $networkInfo = Get-ServerIPInfo

    # Output the network connections
    $networkInfo | ForEach-Object { Write-Host "$($_.Server) : $($_.User) : $($_.IP)" }

    # Get and output Chrome browsing history
    Write-Host "`nChrome Browsing History:"
    $chromeHistory = Get-ChromeHistory
    if ($chromeHistory.Count -eq 0) {
        Write-Host "No Chrome browsing history found."
    } else {
        $chromeHistory | ForEach-Object { Write-Host "$($_.Title) - $($_.URL) - Last Visit: $($_.LastVisitTime)" }
    }

    # Get and output Edge browsing history
    Write-Host "`nEdge Browsing History:"
    $edgeHistory = Get-EdgeHistory
    if ($edgeHistory.Count -eq 0) {
        Write-Host "No Edge browsing history found."
    } else {
        $edgeHistory | ForEach-Object { Write-Host "$($_.Title) - $($_.URL) - Last Visit: $($_.LastVisitTime)" }
    }

    # Sleep for 10 seconds before checking again (adjust as needed)
    Start-Sleep -Seconds 10

    # Optionally, you can add a break condition based on user input:
    # Check if the user presses 'Ctrl+C' to break the loop
}
