#!/bin/bash

url="https://soutien.laquadrature.net/"

exec 2>/dev/null

R="$(wget -O - "$url" | sed -n '/&nbsp;&euro;<\/em>/{s,.*<em>,,;s,&.*,,;p}' | tr '\n' ' ')"
M="${R%% *}"
T="${R#* }"
P="$(($M * 100 / $T))"

echo " π⃝⃞  $P%"

echo "---"

echo "$M € / $T €"

echo "Donner… | href=https://soutien.laquadrature.net/"

exit 0
