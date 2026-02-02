# Getting the Available drives
$Availableid = Get-WmiObject Win32_LogicalDisk | Select-Object -ExpandProperty DeviceID

# Getting the users choice
$choice = Read-Host "Available drive ID are : $($Availableid -join ', ')"


<#
******************* Project-1 *******************
................... Calculating the free space on desired drive ........................
#>



# Getting the free space on the given drive
$free = [System.Math]::Round((Get-cimInstance -classname Win32_LogicalDisk | Where-Object DeviceID -eq "$choice").FreeSpace / 1gb, 2)

# Display the size with appropriate message
if ($free -ge 50){
    Write-Host "Great You have a $free GB of free space"
} 
elseif ($free -ge 25){
    Write-Host "You have $free GB of space"
}
elseif($free -ge 3){
    Write-Host "You have only $free GB space. Clear something"
}
else{
    Write-Host "Warning!! Cear the unnecessary files Only $free GB is available"
}





<#
******************* Project-2 *******************
................... Calculating the Percentage of space used ........................
#>

# Getting the total space of the disk
$total = [math]::Round((Get-cimInstance -classname Win32_LogicalDisk | Where-Object DeviceID -eq "$choice").Size/ 1GB, 2)

# Calculating the Percentage
$percent = [Math]::Round(100 - ($free/$total)*100 ,2)
Write-Host "You have used the $percent % of space on the $choice Drive"