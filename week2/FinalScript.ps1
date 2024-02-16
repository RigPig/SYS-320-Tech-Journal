$files = Get-ChildItem -Recurse -Filter "*.csv"
$files | Rename-Item -NewName { $_.Name -replace '\.csv$', '.log' }
 -PassThru | Get-ChildItem -Recurse
