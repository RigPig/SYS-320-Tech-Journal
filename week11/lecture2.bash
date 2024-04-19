file="/var/log/apache2/access.log"

countingCurlAccess() {
cat "$file" | cut -d' ' -f1,12 | grep 'curl' | sort | uniq -c
}
countingCurlAccess
