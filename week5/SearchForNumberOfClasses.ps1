# Import the functions from ScrapingFunctions.ps1 using dot notation
. .\ScrapingChamplain.ps1

# Call gatherClasses function to get the table
$table = gatherClasses

# Call daysTranslator function to standardize the days in the table
$table = daysTranslator $table

# Group all the instructors by the number of classes they are teaching
$table | Where-Object { $_.Instructor -in $ITSInstructors } |
             Group-Object -Property Instructor |
             Select-Object Count, Name |
             Sort-Object Count -Descending
