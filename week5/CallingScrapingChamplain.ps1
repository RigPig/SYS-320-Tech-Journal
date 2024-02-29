# Import the functions from ScrapingFunctions.ps1 using dot notation
. .\ScrapingChamplain.ps1
# Call gatherClasses function to get the table
$table = gatherClasses

# Call daysTranslator function to standardize the days in the table
$table = daysTranslator $table

# Iterate over each record in the table and print the details
foreach ($record in $table) {
    Write-Host "Class Code: $($record.'Class Code')"
    Write-Host "Title: $($record.Title)"
    Write-Host "Days: $($record.Days -join ', ')"  # Join the days array with a comma
    Write-Host "Time Start: $($record.'Time Start')"
    Write-Host "Time End: $($record.'Time End')"
    Write-Host "Instructor: $($record.Instructor)"
    Write-Host "Location: $($record.Location)"
    Write-Host
}
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" `
           | Where-Object { $_."Instructor" -eq "Furkan Paligu" }