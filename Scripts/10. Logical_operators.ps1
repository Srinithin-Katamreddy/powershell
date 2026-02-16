<#
******************* Project-1 *******************
................... Calculating the free space and free space ........................
#>

# Get-system resource
$cpu= (get-CimInstance win32_Processor).LoadPercentage
$mem = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB

# Check the Resorce conditions
if ($cpu -gt 75 -and $mem -lt 2){
    Write-Host "Critical"
}
elseif ($cpu -gt 70 -or $mem -lt 4){
    Write-Host "Warning"
}
elseif ($cpu -lt 20 -and $mem -gt 8) {
    Write-Host "optimal"
}
else{
    Write-Host "Good"
}




<#
******************* Project-2 *******************
................... Calculating the office hours or not (9 to 17) ........................
#>

#Get Current day & Hours
$day = (get-Date).DayOfWeek
$hrs = (Get-Date).Hour

# Check if its a weekday
$isweek = $day -ge 1 -and $day -le 5

#check if its bussiness hours
$isbusinesshrs = $hrs -ge 9 -and $hrs -lt 17

# Meeting hours
$ismeetingtime = Read-Host "Is there any meeting time"
$meetingday = Read-Host "Enter meeting day"

# Evaluating conditions
if ($ismeetingtime -gt 9 -and $ismeetingtime -lt 17 -and $meetingday -gt 1 -and $meetingday -le 5){
    Write-Host "I have a meeting at $ismeetingtime"
} elseif ($isweek -and $isbusinesshrs) {
    Write-Host "Its a Bussiness hours I don't have any meetings"
}
else{
    Write-Host "Not a bussiness hours"
}