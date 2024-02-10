# Function to get login and logoff records from Windows Events
function Get-LoginLogoffRecords {
    param (
        [int]$DaysAgo = 14
    )

    # Get login and logoff records from Windows events for the specified number of days
    $loginouts = Get-EventLog System -After (Get-Date).AddDays(-$DaysAgo) | Where-Object {$_.Source -eq "Microsoft-Windows-Winlogon"}

    $loginoutsTable = @() # Empty array to fill customly

    foreach ($event in $loginouts) {
        # Creating event property value
        $eventType = ""
        if ($event.InstanceID -eq 7001) { $eventType = "Logon" }
        elseif ($event.InstanceID -eq 7002) { $eventType = "Logoff" }

        # Creating user property value
        $sid = $event.ReplacementStrings[1]
        $user = (New-Object System.Security.Principal.SecurityIdentifier $sid).Translate([System.Security.Principal.NTAccount]).Value

        # Adding each new line in form of a custom object to our empty array
        $loginoutsTable += [PSCustomObject]@{
            "Time" = $event.TimeGenerated
            "Id" = $event.InstanceID
            "Event" = $eventType
            "User" = $user
        }
    }

    return $loginoutsTable
}

# Function to obtain computer start and shut-down times
function Get-ComputerStartShutdownTimes {
    param (
        [int]$DaysAgo = 14
    )

    # Get computer start and shut-down records from Windows events for the specified number of days
    $startShutDownEvents = Get-EventLog System -After (Get-Date).AddDays(-$DaysAgo) | Where-Object {$_.EventID -eq 6005 -or $_.EventID -eq 6006}

    $shutdownsTable = @() # Empty array to fill customly

    foreach ($event in $startShutDownEvents) {
        # Determine the event type based on the EventId
        $eventType = ""
        if ($event.EventID -eq 6005) { $eventType = "Start" }
        elseif ($event.EventID -eq 6006) { $eventType = "Shutdown" }

        # Adding each new line in the form of a custom object to our empty array
        $shutdownsTable += [PSCustomObject]@{
            "Time" = $event.TimeGenerated
            "Id" = $event.EventID
            "Event" = $eventType
            "User" = "System"
        }
    }

    return $shutdownsTable
}

# Call the function with the parameter and print the results on the screen
$daysToRetrieve = 14

Write-Host "Login and Logoff Records:"
Get-LoginLogoffRecords -DaysAgo $daysToRetrieve | Format-Table -AutoSize

Write-Host "`nComputer Start and Shutdown Times:"
Get-ComputerStartShutdownTimes -DaysAgo $daysToRetrieve | Format-Table -AutoSize