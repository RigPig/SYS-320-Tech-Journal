function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.31/Courses.html

    # Get all the tr elements of HTML document
    $trs = $page.ParsedHtml.getElementsByTagName("tr")

    # Empty array to hold results
    $FullTable = @()
    for ($i = 0; $i -lt $trs.length; $i++) { # Going over every tr element
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagname("td")

        # Want to separate start time and end time from one time field
        $Times = $tds[5].innerText -split "-"

        $FullTable += [PSCustomObject]@{
            "Class Code"  = $tds[0].innerText; `
            "Title"       = $tds[1].innerText; `
            "Days"        = $tds[4].innerText; `
            "Time Start"  = $Times[0].Trim(); `
            "Time End"    = $Times[1].Trim(); `
            "Instructor"  = $tds[6].innerText; `
            "Location"    = $tds[9].innerText; `
        }
    }

    return $FullTable
}
function daysTranslator($FullTable){
    # Go over every record in the table
    for($i=0; $i -lt $FullTable.length; $i++){
        # Empty array to hold days for every record
        $Days = @()

        # If you see "M" -> Monday
        if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }

        # If you see "T" followed by T,W, or F -> Tuesday
        if($FullTable[$i].Days -ilike "*T[WF]*"){ $Days += "Tuesday" }

        # If you see "W" -> Wednesday
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

        # If you see "TH" -> Thursday
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }

        # If you see "F" -> Friday
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }

        # Make the switch
        $FullTable[$i].Days = $Days
    }

    return $FullTable
}

$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" `
           | Where-Object { $_."Instructor" -eq "Sheila Liming" }

return gatherClasses