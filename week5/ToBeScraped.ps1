$scraped_page = Invoke-WebRequest -Uri http://10.0.17.31/ToBeScraped.html

$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object { $_.className -eq "div-1" } | ForEach-Object { $_.innerText }
$divs1