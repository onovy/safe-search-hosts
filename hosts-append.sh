#!/bin/sh

FILE=hosts
MARKER_BEGIN="## SafeSearch BEGIN ##"
MARKER_END="## SafeSearch END ##"

(
sed -n "1,/^$MARKER_BEGIN/{/^$MARKER_BEGIN/!p;}" "$FILE"
echo "$MARKER_BEGIN"
./hosts.sh
echo "$MARKER_END"
sed -n "/^$MARKER_END/,\${/^$MARKER_END/!p;}" "$FILE"
) >"$FILE.new"

mv "$FILE.new" "$FILE"
