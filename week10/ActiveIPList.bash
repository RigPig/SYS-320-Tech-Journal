#!/bin/bash
# Usage: bash IPList.bash 10.0.17 <Prefix>
[ -z $1 ] && echo "Usage: <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify input length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {1..254}
do 
    ping -c 1 $prefix.$i | grep "64 bytes" | cut -d " " -f4 | tr -d ":"
done
