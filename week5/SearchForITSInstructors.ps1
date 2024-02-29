# Import the functions from ScrapingFunctions.ps1 using dot notation
. .\ScrapingChamplain.ps1

# Call gatherClasses function to get the table
$table = gatherClasses

# Call daysTranslator function to standardize the days in the table
$table = daysTranslator $table

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique

$ITSInstructors = $table | Where-Object { $_."Class Code" -like "SYS*" -or `
                                               $_."Class Code" -like "NET*" -or `
                                               $_."Class Code" -like "SEC*" -or `
                                               $_."Class Code" -like "FOR*" -or `
                                               $_."Class Code" -like "CSI*" -or `
                                               $_."Class Code" -like "DAT*" } | `
                                  Select-Object -ExpandProperty Instructor | `
                                  Sort-Object -Unique
$ITSInstructors
