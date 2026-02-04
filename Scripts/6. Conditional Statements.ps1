
<#
******************* Project-1 *******************
................... Getting the Process details ........................
#>

# Create the variables
$Process_name = Read-Host "Enter the name"
$Process_object = Get-Process $Process_name -ErrorAction SilentlyContinue

# check the process is running or not
<#
- if($Process_object -eq $null)
- if(not $process_object)
- if(! $process_object)
#>

if($Process_object -eq $null) {
    Write-Host "$process_name is not currently running"
}
elseif ($Process_object.Responding) {
    Write-Host "$process_name is working currently"
}
else {
    Write-Host "$process_name is unresponsive, closing the process"
    $Process_object.Kill()
}




<#
******************* Project-2 *******************
................... Getting the storage details ........................
#>

# Getting the free space in GB of E drive
$freespace = (Get-cimInstance -classname Win32_LogicalDisk | Where-Object DeviceID -EQ 'c:').FreeSpace / 1GB

# Check the free space & provide appropriate message
if ($freespace -gt 50){
    Write-Host "Plenty of space is available"
}
elseif ($freespace -gt 20) {
    Write-Host "Your space is ok"
}
elseif($freespace -gt 2){
    Write-Host "Warning!! you have only $freespace GB free"
}
else{
    Write-Host "Crital $freespace GB free only delete un necessary files"
}