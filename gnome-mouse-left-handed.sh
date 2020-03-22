#!/usr/bin/env bash

# text labels
LL="L"
LR="R"
LLL="Left-handed"
LLR="Right-handed"

key="/org/gnome/desktop/peripherals/mouse/left-handed"

LH="$(dconf read "$key")"

if [ "$LH" == "true" ]; then
    M="🖱$LL"
    TL="☑"
    TR="☐"
else
    M="🖱$LR"
    TL="☐"
    TR="☑"
fi

echo "$M | iconName=mouse"
echo "---"


echo "$TL$LLL | bash='dconf' param1='write' param2='$key' param3='true' terminal=false refresh=true"
echo "$TR$LLR | bash='dconf' param1='write' param2='$key' param3='' terminal=false refresh=true"

echo "---"
echo "Refresh | refresh=true"

