#!/bin/bash

# Configuration
if [ -z "$XDG_CONFIG_HOME" ]; then
        export XDG_CONFIG_HOME="$HOME/.config"
fi
. $XDG_CONFIG_HOME/user-dirs.dirs 


while true
do
	pid_list=`grep PID_ICON $XDG_DESKTOP_DIR/*|sed s/\;\ PID_ICON=//|sed s/.*://`
	for pid in $pid_list
	do
		# echo $pid
		if [ ! -d /proc/$pid ]
		then
			# echo $pid not exists
			to_be_removed=`grep -l "PID_ICON=$pid" $HOME/Desktop/*`
			rm $to_be_removed
			rm ${to_be_removed}.info
			touch $HOME/.refresh
		fi
	done
	sleep 1
done
