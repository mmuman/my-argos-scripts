#!/bin/bash

url="https://www.laquadrature.net/donner/"

exec 2>/dev/null

R="$(wget -O - "$url" | sed -n '/^<p><img.*barre.*svg/{s,^<p><img.*barre/,,;s,\.svg"></p>$,,;s/[^0-9]//g;p};/réunir au moins/{s/.*réunir au moins //;s/€ supplémentaires.*//;s/[^0-9]//g;p}' | tr '\n' ' ')"
T="${R#* }"
P="${R%% *}"
M="$(($P * $T / 100))"

echo " π⃝⃞  $P%"

echo "---"

echo "$M € / $T €| href=https://www.laquadrature.net/donner/"

echo "Donner… | href=https://don.laquadrature.net/"

exit 0
