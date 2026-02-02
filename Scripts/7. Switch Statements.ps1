<#
******************* Project-1 *******************
................... Creating the simple Network troubleshoot ........................
#>


# Displaying the options
Write-Host "Simple network Troubleshoot"
Write-Host "1. Check the network connection"
Write-Host "2.View IP configuration `n3.Flush DNS"

#Get the user Input
$choice = Read-Host "Enter your choice"

# Switch Condition
Switch($choice){
    "1"{
        # Check the internet condition
        $result = Test-Connection -ComputerName google.com -Quiet
        if ($result -eq "True"){
            Write-Host "Internet connection is working"
        } else{
            Write-Host "unable to connect to internet"
        }
    }
    "2"{
        # Dispay IP configuration
        $ipaddr = (Get-NetIPConfiguration).ipv4address.ipaddress
        $defaultGW = (Get-NetIPConfiguration).ipv4defaultGateway.NextHop
        Write-Host "IPv4 address: $ipaddr"
        Write-Host "Default Gateway: $defaultGW"
    }
    "3"{
        # flush DNS cache
        Clear-DnsClientCache
        Write-Host "DNS client cache is flushed successfully"
    }
    default {
        # Invalid Selection
        Write-Host"Invalid Selection. Select again"
    }
}






<#
******************* Project-2 *******************
................... Getting the System Information ........................
#>

# Displaying the options
Write-Host "Select the options from the below: `nA. Operating System `nB.CPU Details `n`C. Total Memory `nD. Current User details and Windows directory"

#Get the user Input
$opt = Read-Host "Enter your choice"

# Switch Statement
switch ($opt) {
    "A"{
        # Operating System Info
        $os = Get-cimInstance Win32_OperatingSystem
        $os_name = $os.Caption
        $os_version = $os.Version
        Write-Host "Operating System : $os_name"
        Write-Host "Version : $os_version"
    }
    "B"{
        # CPU Information
        $cpu = Get-CimInstance Win32_Processor
        $cpu_name = $cpu.Name
        $cpu_cores = $cpu.NumberOfCores
        $cpu_speed = $cpu.MaxClockSpeed
        $cpu_status = $cpu.CpuStatus
        $cpu_Part = $cpu.PartNumber
        Write-Host " CPU Name : $cpu_name `n No. of cores : $cpu_cores `n Max clock speed : $($cpu_speed/1000) GHz"
        write-Host " CPU Status : $cpu_status `n CPU part number : $cpu_Part"
    }
    "C"{
        # Calculate & Display total Memory in GB
        $mem = [math]::Round((Get-cimInstance win32_ComputerSystem).TotalPhysicalMemory/ 1GB, 2)
        Write-Host "Total Physical Memory : $mem GB"
    }
    "D"{
        # Display the current user
        $username = $env:USERNAME
        Write-Host "current user: $username"
        Write-Host "Domain name : $env:Domainname"
        Write-Host "user profile : $env:userprofile"
        Write-Host "Windows Directory : $env:windir"
    }
    default{
        # Invalid Selection
        Write-Host"Invalid Selection. Select again"
    }
}