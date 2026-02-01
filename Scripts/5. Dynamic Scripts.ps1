# Example scripts
$name= Read-Host "Enter the username"
Write-Host "$name"


<#
*************** Project-1 ***************
#>

# prompt the user for folder name, custom message, and get current date
$appname = Read-Host  "Enter folder name"
$message = Read-Host "Enter the text for the custom message"
$appdir = "${appname}_Dir"
$time= Get-Date -Format "YYYY-MM-dd HH:mm:ss"

# create the directory
New-Item E:\$appdir  -ItemType Directory

# create a text file
New-Item E:\$appdir\config.txt -ItemType File

# Adding the content to the file
Add-Content -Path "E:\$appdir\config.txt" -Value "configuration for $appname `nCustom Message:`n$message `n`nCreated on:$time"

<#Also written as
Add-Content -Path "E:\$appdir\config.txt" -Value "configuration for $appname `nCustom Message:`n$message `n`nCreated on:$(Get-Date -Format "YYYY-mm-DD")"
#>

#verify the things
Get-childItem $appdir
Get-content "$appdir\config.txt"