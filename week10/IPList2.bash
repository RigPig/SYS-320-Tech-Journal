#!/bin/bash
# List all the ips in the given network prefix /24 only

# Usage: bash IPList.bash 10.0.17

# Prefix is the first input taken
prefix=$1

# Verify input length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17.n" && exit 1

for i in {0..255}
do
  echo "$prefix.$i"
done
