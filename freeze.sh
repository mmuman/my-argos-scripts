#!/usr/bin/env bash

# freeze.sh - argos / BitBar script to send STOP/CONT signals to apps

lf='
'

echo "❄"
echo "---"

kernel="$(uname -s)"
case "$kernel" in
	Linux)
		IFS="$lf"
		TOP=($(ps axu --no-headers --sort -pcpu | grep -v '^.\{47\}T' | grep -v Xorg | head -5 | awk '{print $2 " " $11; }'))
		FROZEN=($(ps axu | grep '^.\{47\}T' | awk '{print $2 " " $11; }'))
		unset IFS
		;;
	*)
		echo "TODO: Write code for $kernel."
		exit 1
		;;
esac


echo "Active apps:"
for app in "${TOP[@]}"; do
	pid="${app%% *}"
	echo "⛄ $app | bash='kill' param1='-STOP' param2='$pid' terminal=false refresh=true"
done
echo "---"
echo "Frozen apps:"
for app in "${FROZEN[@]}"; do
	pid="${app%% *}"
	echo "⛇ $app | bash='kill' param1='-CONT' param2='$pid' terminal=false refresh=true"
done
echo "---"
echo "Refresh | refresh=true"

