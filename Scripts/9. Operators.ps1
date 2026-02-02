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




<#
******************* Project-2 *******************
#>

# Prompt the user for the date
$userdate = Read-Host "Enter the date in the yyyy-MM-DD format"

#checking the user entered the date in the correct format or not
if($userdate -as [String]){
    Write-Host "Good Job You entered a string"

    # using a wild card Pattern to check input matches yyyy-mm-dd format
    # ???? represents any four charcters (for the year)
    # ?? represents any two characters (for the month and day)

    if($userdate -like "????-??-??"){
        Write-Host "Fanstastic!! Correct Format"
    }
    else{
        Write-Host "Change Format to yyyy-mm-dd"
    }
}
else{
    Write-Host "OOPS!! Try again"
}