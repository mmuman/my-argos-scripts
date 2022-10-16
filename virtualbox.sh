#!/usr/bin/env bash

lf='
'
IFS="$lf"
VMS=($(vboxmanage list vms))
unset IFS

echo "VBox | iconName=virtualbox"
echo "---"
for vml in "${VMS[@]}"; do
	vmname="${vml% *}"
	vmname="${vmname%\"}"
	vmname="${vmname#\"}"
	vmid="${vml##* }"
	status="$(vboxmanage showvminfo "$vmid" | sed -n '/^State:/{s/State:\s*//;s/ (.*//;p;q}')"
	#echo "$status"
	actions=''
	case "$status" in
		'powered off')
			status='⏹'
			actions="--⏵ Start | bash='vboxmanage' param1='startvm' param2='$vmid' terminal=false refresh=true"
			;;
		'running')
			status="⏵"
			if which xwininfo >/dev/null 2>&1 && which xdotool >/dev/null 2>&1 ; then
				wid="$(xwininfo -root -children | grep "$vmname \[.*\] - Oracle VM VirtualBox\"" | sed 's/ ".*//')"
				actions+="--🗔 Display | bash='xdotool windowactivate $wid' terminal=false refresh=true $lf"
			fi
			actions+="--⏸ Pause | bash='vboxmanage' param1='controlvm' param2='$vmid' param3='pause' terminal=false refresh=true $lf"
			actions+="--⏹ ACPI Shutdown | bash='vboxmanage' param1='controlvm' param2='$vmid' param3='acpipowerbutton' terminal=false refresh=true $lf"
			actions+="--😴 ACPI Suspend | bash='vboxmanage' param1='controlvm' param2='$vmid' param3='acpisleepbutton' terminal=false refresh=true"
			;;
		'paused')
			status='⏸'
			if which xwininfo >/dev/null 2>&1 && which xdotool >/dev/null 2>&1 ; then
				wid="$(xwininfo -root -children | grep "$vmname \[.*\] - Oracle VM VirtualBox\"" | sed 's/ ".*//')"
				actions+="--🗔 Display | bash='xdotool windowactivate $wid' terminal=false refresh=true $lf"
			fi
			actions+="--⏵ Resume | bash='vboxmanage' param1='controlvm' param2='$vmid' param3='resume' terminal=false refresh=true"
			;;
		*)
			status='?';;
	esac
	echo "$status $vmname | ansi=true refresh=true"
	echo "$actions"
done
echo "---"
echo "Refresh | refresh=true"

