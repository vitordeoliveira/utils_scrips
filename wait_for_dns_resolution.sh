#!/bin/bash

# Checking for the resolved IP address from the end of the command output. Refer
# the normal command output of nslookup to understand why.

resolvedIP=$(nslookup "$1" | awk -F':' '/^Address: / { matched = 1 } matched { print $2}' | xargs)

# Deciding the lookup status by checking the variable has a valid IP string
COUNTER=0
echo "Waiting resolution (MAX_5MIN) "
while [ "$resolvedIP" == "" ] && [ $COUNTER -lt 300 ]; do
sleep 1s
echo "."
((COUNTER++))
done
