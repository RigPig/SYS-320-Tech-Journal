function Display-Menu {
    Write-Host "Menu:"
    Write-Host "1. Display last 10 Apache logs"
    Write-Host "2. Display last 10 failed logins for all users"
    Write-Host "3. Display at risk users"
    Write-Host "4. Start Chrome web browser and navigate to champlain.edu"
    Write-Host "5. Exit"
}

function Get-Input {
    $input = Read-Host "Enter your choice (1-5)"
    while ($input -notin '1','2','3','4','5') {
        Write-Host "Invalid input. Please enter a number between 1 and 5."
        $input = Read-Host "Enter your choice (1-5):"
    }
    return $input
}

function Get-Last10ApacheLogs {
    $logs = Get-Content -Path C:\xampp\apache\logs\access.log -Tail 10
    return $logs
}

function Get-FailedLogins {
    param (
        [int]$timeBack
    )

    $failedLogins = Get-EventLog Security -After (Get-Date).AddDays(-$timeBack) |
                    Where-Object { $_.InstanceID -eq 4625 } |
                    ForEach-Object {
                        $account = $_.ReplacementStrings[5]  

                        [PSCustomObject]@{
                            Time = $_.TimeGenerated
                            Id = $_.InstanceId
                            Event = "Failed"
                            User = $account
                        }
                    }

    return $failedLogins
     Get-FailedLogins -timeBack 1
}

function Display-AtRiskUsers {
    param (
        [int]$daysBack
    )

    $failedLogins = Get-FailedLogins -timeBack $daysBack
    $atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 } | Select-Object -ExpandProperty Name
    return $atRiskUsers
}

function Start-ChromeAndNavigate {
    $chrome = Get-Process -name "chrome" -ErrorAction SilentlyContinue
    if ($chrome -eq $null) {
        Start-Process "chrome" -ArgumentList "https://www.champlain.edu"
    }
    else {
        Stop-Process -Name "chrome" -Force
    }
}


do {
    Display-Menu
    $choice = Get-Input

    switch ($choice) {
        '1' { Get-Last10ApacheLogs }
        '2' { Get-FailedLogins -timeBack 10 }
        '3' { Display-AtRiskUsers -daysBack 7 }
        '4' { Start-ChromeAndNavigate }
        '5' { Write-Host "Exiting" }
    }
} while ($choice -ne '5')