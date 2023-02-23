#!/bin/bash

declare -A IPS4
declare -A IPS6

while read -r LINE; do
    FROM=${LINE% *}
    TO=${LINE#* }

    if [ ${IPS4["$TO"]+_} ]; then
        IP4=${IPS4["$TO"]}
    else
        IP4=$(getent ahostsv4 "$TO" | grep ' STREAM ' | head -n 1 | cut -d ' ' -f 1)
        IPS4["$TO"]="$IP4"
    fi

    if [ ${IPS6["$TO"]+_} ]; then
        IP6=${IPS6["$TO"]}
    else
        IP6=$(getent ahostsv6 "$TO" | grep ' STREAM ' | head -n 1 | cut -d ' ' -f 1 | grep -v "^::ffff:" )
        IPS6["$TO"]="$IP6"
    fi

    if [[ $FROM == "*"* ]] ; then
        FROM="${FROM:1}"
        FROM="$FROM www.$FROM"
    fi

    if [ ! -z "$IP4" ] ; then
        echo "$IP4 $FROM"
    fi
    if [ ! -z "$IP6" ] ; then
        echo "$IP6 $FROM"
    fi
done
