#!/bin/bash
sleep 1
id=$(xinput list | grep 'AT Translated Set 2 keyboard' | grep -oEi '[0-9]{2}')


function get_state()
{
	return "$(xinput list-props $id | grep 'Device Enabled' | grep -oEi '[0-9]$')"
}

get_state
state=$?

if [[ $state = 0 ]];
    then
        echo "Enabling internal keyboard"
        xinput enable $id
		setxkbmap us -variant colemak -option caps:ctrl_modifier
elif [[ $state = 1 ]]; then
		echo "Disabling internal keyboard"
        xinput disable $id
		setxkbmap us 
fi

get_state
state=$?

notify-send "$(echo $state | awk '{printf "Internal keyboard "}; match($0, /[0-9]$/) {if(substr($0, RSTART, RLENGTH) > 0) print "enabled"; else print "disabled"}')"
