i=$(ip addr | grep -o -E 'inet ([0-9]{1,3}\.){3}[0-9]{1,3}' |  grep -v '127.0.0.1')
echo "$i"

