#!/bin/bash
# xscreensaverstopper.sh

# This script is licensed under GNU GPL version 2.0 or above

# Uses elements from lightsOn.sh
# Copyright (c) 2011 iye.cba at gmail com
# url: https://github.com/iye/lightsOn
# This script is licensed under GNU GPL version 2.0 or above

# Description: Restarts xscreensaver's idle countdown while 
# full screen applications are running.  
# Checks every 30 seconds to see if a full screen application
# has focus, if so then the xscreensaver is told to restart 
# its idle countdown.


# enumerate all the attached screens
displays=""
while read id
do
    displays="$displays $id"
done< <(xvinfo | sed -n 's/^screen #\([0-9]\+\)$/\1/p')

checkFullscreen()
{

    # loop through every display looking for a fullscreen window
    for display in $displays
    do
        #get id of active window and clean output
        activ_win_id=`DISPLAY=:0.${display} xprop -root _NET_ACTIVE_WINDOW`
        activ_win_id=${activ_win_id:40:9}
        
        # Check if Active Window (the foremost window) is in fullscreen state
        isActivWinFullscreen=`DISPLAY=:0.${display} xprop -id $activ_win_id | grep _NET_WM_STATE_FULLSCREEN`
        if [[ "$isActivWinFullscreen" == *NET_WM_STATE_FULLSCREEN* ]];then
        	xscreensaver-command -deactivate
	    fi
    done
}

while sleep $((30)); do
    checkFullscreen
done

exit 0
