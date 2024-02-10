
. (Join-Path $PSScriptRoot "Week3Script1.ps1")

clear

# Get login and logoff records from the last 15 days
$daysToRetrieveLoginLogoff = 15
$loginLogoffRecords = Get-LoginLogoffRecords -DaysAgo $daysToRetrieveLoginLogoff

Write-Host "Login and Logoff Records from the last $daysToRetrieveLoginLogoff days:"
$loginLogoffRecords | Format-Table -AutoSize

# Get shutdown records from the last 25 days
$daysToRetrieveShutdown = 25
$shutdownRecords = Get-ComputerStartShutdownTimes -DaysAgo $daysToRetrieveShutdown | Where-Object { $_.Event -eq "Shutdown" }

Write-Host "`nShutdown Records from the last $daysToRetrieveShutdown days:"
$shutdownRecords | Format-Table -AutoSize

# Get startup records from the last 25 days
$startupRecords = Get-ComputerStartShutdownTimes -DaysAgo $daysToRetrieveShutdown | Where-Object { $_.Event -eq "Start" }

Write-Host "`nStartup Records from the last $daysToRetrieveShutdown days:"
$startupRecords | Format-Table -AutoSize