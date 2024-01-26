$chrome = Get-Process -name "chrome" -ErrorAction SilentlyContinue
if ($chrome -eq $null) {
Start-Process "chrome" -ArgumentList "https://www.champlain.edu" }
else { Stop-Process -Name "chrome" -Force }