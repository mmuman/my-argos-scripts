#!/usr/bin/env bash

# emacs.sh - argos / BitBar script to switch between buffers in Emacs
# uses emacsclient (needs M-x server-start in Emacs)

lf='
'
echo "ε"
echo "---"

IFS="$lf"
buffers=($(emacsclient -e '(buffer-list)' | sed 's/^(//;s/>)$//;s/>\? \?#<buffer /\n/g' | grep -v '^ \?\*')) || echo "Emacs server not found (M-x server-start)"
unset IFS

for buffer in "${buffers[@]}"; do
	echo " $buffer | bash='emacsclient' param1='-e' param2='(progn (raise-frame) (switch-to-buffer \"$buffer\"))' terminal=false refresh=true"
done
echo "---"
echo "Refresh | refresh=true"

