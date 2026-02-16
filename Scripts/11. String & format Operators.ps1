# Enter the file location
$fileLocation = Read-Host "Enter the file path for setting as default location"
Set-Location $fileLocation

# Prompt for filename
$filename = Read-Host "Enter the file name"

# Check if file exists
if (Test-Path $filename){
    Write-Host "File-Found! Trying to rename"


# Retriveing the file objects
$fileInfo = Get-Item $filename

# Creating new name
# Method-1
$newname1 = $fileInfo.BaseName + "_" + $(Get-Date -Format "yyyyMMdd") + $fileInfo.Extension

#Method-2
$newname2 = "$($fileInfo.BaseName)_$(Get-Date -Format "yyyyMMdd")$($fileInfo.Extension)"

#rename file
Rename-Item $filename $newname1
Write-Host "File Successfully renamed from $($fileInfo.name) to $($newname1) or $($newname2)"
}
else{
    Write-Host "file not found"
    exit
}


# Changing the above file to add the date as creation time.

# Extract the Creation date
$creation = $fileInfo.CreationTime

#display the date and renaming it to new file
Write-Host "`nFile Was reated on : $((Get-Date $creation -Format "yyyyMMdd"))"

$newName = "$(($creation).ToString('yyyyMMdd'))_$($fileInfo.BaseName)$($fileInfo.Extension)"
Rename-Item $newname1 $newName
Write-Host "File Successfully renamed from $($fileInfo.name) to $($newName)"
