#!/bin/bash

url="https://www.triplea.fr/alchimie/pages/participants.php"

exec 2>/dev/null

R="$(wget -O - "$url" | sed -n '/^Il y a .*réservations à l.Alchimie/{s/^Il y a //;s/&nbsp;réservations à l.Alchimie.*$//;s/[^0-9]//g;p}')"

echo "✓A $R"

echo "---"

echo "$R inscriptions| href=$url"

exit 0
