#!/bin/bash

logFile="/var/log/apache2/access.log"

displayAllLogs(){
    cat "$logFile"
}

displayOnlyIPs(){
    cut -d ' ' -f 1 "$logFile" | sort | uniq -c
}
#like displayOnlyIPs but it displays only pages
displayOnlyPages(){
    cut -d ' ' -f 7 "$logFile" | sort | uniq -c
}

histogram(){
    awk '{print $4}' "$logFile" | cut -d '[' -f 2 | cut -d : -f 1 | sort | uniq -c
}
#frequentVisitors:
#only display the IPs that have more than 10 visits
frequentVisitors(){
    histogram | awk '$1 >= 10 {print $2, $1}'
}
#function: suspiciousVisitors
#use indicators of attack to filter records and only display unique count of IP addresses
suspiciousVisitors(){
    egrep -i -f ioc.txt "$logFile" | cut -d ' ' -f 1 | sort | uniq -c
}

while true; do
    echo "Please select an option:"
    echo "[1] Display all Logs"
    echo "[2] Display only IPS"
    echo "[3] Display only Pages"
    echo "[4] Histogram"
    echo "[5] Frequent Visitors"
    echo "[6] Suspicious Visitors"
    echo "[7] Quit"

    read -r userInput
    echo ""

    if [[ "$userInput" == "1" ]]; then
        echo "Displaying all logs:"
        displayAllLogs
    elif [[ "$userInput" == "2" ]]; then
        echo "Displaying only IPS:"
        displayOnlyIPs
    elif [[ "$userInput" == "3" ]]; then
        echo "Displaying only Pages:"
        displayOnlyPages
    elif [[ "$userInput" == "4" ]]; then
        echo "Histogram:"
        histogram
    elif [[ "$userInput" == "5" ]]; then
        echo "Frequent Visitors:"
        frequentVisitors
    elif [[ "$userInput" == "6" ]]; then
        echo "Suspicious Visitors:"
        suspiciousVisitors
    elif [[ "$userInput" == "7" ]]; then
        echo "Goodbye!"
        break
    else
        echo "Please enter a valid input from 1-7"
        echo ""
    fi
done
