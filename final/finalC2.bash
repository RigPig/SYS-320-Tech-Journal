logs=$1
ioc=$2
cat "$logs" | grep -i -f "$ioc" | cut -d' ' -f1,4,7 | tr -d '[' > report.txt
