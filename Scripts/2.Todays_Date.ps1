# Displaying Today's Date

Write-Host "Todays date is:"
Get-Date # Sunday, February 1, 2026 2:02:26 PM
Get-Date -Format "dddd, MMMM-dd-yyyy" # Sunday, February-01-2026
Get-Date -Format "dddd, MM-dd-yyyy" # Sunday, 02-01-2026
Get-Date -Format "dddd, MMM-dd-yyyy" # Sunday, Feb-01-2026