<#
******************* Project-1 *******************
#>

$userinput = Read-Host "Enter a number"

# Using the "as" Operator to check is it number or not
if($userinput -as [int]){
    Write-Host "You have enterd the number"
}
else{
    Write-Host "Its not a number"
}


# Using the regex to check is it number or not
if($userinput -match '^\d+$'){
    Write-Host "You have enterd the number"
}
else{
    Write-Host "Its not a number"
}
