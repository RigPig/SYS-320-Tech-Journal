function Get-ApacheLogs {
    param (
        [string]$HTTPCode,
        [string]$WebBrowser,
        [string]$PageVisited
    )

    $logs = Get-Content -Path C:\xampp\apache\logs\access.log
    $filteredLogs = $logs | Select-String "$HTTPCode" | Select-String "$WebBrowser" | Select-String "$PageVisited"

    $IPAddresses = $filteredLogs | ForEach-Object {
        $_.Line -split '\s+' | Select-Object -Index 0
    }

    return $IPAddresses | Sort-Object -Unique
}
 Get-ApacheLogs -HTTPCode "404" -WebBrowser "chrome" -PageVisited ".html"
 
