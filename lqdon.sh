#!/bin/bash

url="https://www.laquadrature.net/donner/"

exec 2>/dev/null

R="$(wget -O - "$url" | sed -n '/^Soit .*, sachant que/{s/^Soit //;s/€,.*$//;s/[^0-9]//g;p};/^<p>Depuis/{s/.*objectif de //;s/€ de.*//;s/[^0-9]//g;p}' | tr '\n' ' ')"
M="${R#* }"
T="${R%% *}"
P="$(($M * 100 / $T))"

echo " π⃝⃞  $P%"

echo "---"

echo "$M € / $T €| href=https://www.laquadrature.net/donner/"

echo "Donner… | href=https://don.laquadrature.net/"

exit 0
