#!/bin/bash

url="https://www.laquadrature.net/donner/"

exec 2>/dev/null

R="$(wget -O - "$url" | sed -n '/^<p><span class="pourcents">/{s,^<p><span class="pourcents">,,;s,%</span> des dons .*$,,;s/[^0-9]//g;p};/réunir au moins/{s/.*réunir au moins //;s/€ supplémentaires.*//;s/[^0-9]//g;p}' | tr '\n' ' ')"
T="${R#* }"
P="${R%% *}"
M="$(($P * $T / 100 / 100))"
P="$(("$P"/100))"

# Some Unicode magic here:
# CF 80 = U+03C0 GREEK SMALL LETTER PI
# e2 83 9d = U+20DD COMBINING ENCLOSING CIRCLE
# e2 83 9e = U+20DE COMBINING ENCLOSING SQUARE
echo -e " \xcf\x80\xe2\x83\x9d\xe2\x83\x9e  $P%"

echo "---"

echo "$M € / $T €| href=https://www.laquadrature.net/donner/"

echo "Donner… | href=https://don.laquadrature.net/"

exit 0
