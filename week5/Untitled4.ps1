# Import the functions from ScrapingFunctions.ps1 using dot notation
. .\ScrapingChamplain.ps1

# Call gatherClasses function to get the table
$table = gatherClasses

# Call daysTranslator function to standardize the days in the table
$table = daysTranslator $table

# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time

$table | Where-Object { $_.Location -like "JOYC 310" -and ($_.days -contains "Monday")} | `
    Sort-Object "Time Start" | `
    Select-Object "Time Start", "Time End", "Class Code"
