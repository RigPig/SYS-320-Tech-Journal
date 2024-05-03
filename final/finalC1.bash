
page=$(curl -s http://10.0.17.5/IOC.html)

ioc=$(echo "$page" | grep -oP '(?<=<td>).*?(?=</td>)' | awk 'NR%2==1')
echo "$ioc" > IOC.txt
