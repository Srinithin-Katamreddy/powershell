#set location to E drive
Set-location E:

#Create a new directory 
New-Item 'E:\Powershell\Folder1\Folder1' -ItemType Directory

# Creating a text file
New-Item -path 'E:\Powershell\Folder1\Folder1\textfile.txt' -ItemType File

# Add content to file
Add-Content -Path "E:\Powershell\Folder1\Folder1\textfile.txt" -value ".......................`nI am adding the content using the powershell. `nPowershell is very easy to laern. `n........................................."

#verifying the text
Get-childItem E:\Powershell\Folder1\Folder1
get-content "E:\Powershell\Folder1\Folder1\textfile.txt"