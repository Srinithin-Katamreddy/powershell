# creating a file
New-Item 'E:\Powershell\Folder1\Folder2' -ItemType Directory
$myfile="E:\Powershell\Folder1\Folder2\textfile.txt"

New-Item $myfile -ItemType File

# Add Content
Add-Content -Path $myfile -value ".......................`nI am adding the content using the powershell. `nPowershell is very easy to laern. `n........................................."

# Displaying content
Get-content -path $myfile


# Add a timestamp to thje name of our file
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$myfile1 = "E:\Powershell\Folder1\Folder2\textfile.txt_$time"
$myfile1




##################################### Another Project ######################
# Variable setup
$dir = "My_Directory"
$file = "config.txt"
$dirName = "${dir}_Folder"

# Creating Directory
New-item -Path "E:\Powershell\$dirName" -ItemType Directory

# Creating file
New-Item "E:\Powershell\$dirName\$file" -ItemType File

