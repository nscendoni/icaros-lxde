#!/bin/bash

echo ciao mondo >/tmp/log
active_window=`xdotool getactivewindow`
pid=`xdotool getwindowpid $active_window=`
process_name=`ps -q $pid |grep $pid |awk '{ print $4 }'`
window_name=`xdotool getwindowname $active_window`
#todo: convert file, resize it and manage errors
icon_name=`/home/aros/find_icon.py $process_name`

#todo: manage situations with special characters or files with the same name
desktop=/usr/lib/icaros/MyWorkspace/Desktop
file_name=$desktop/$process_name
cat >$file_name <<EOF
echo "xdotool windowactivate $active_window">Home:.icarosd/runme
delete MyWorkspace:Desktop/`basename $file_name` >NIL:
delete MyWorkspace:Desktop/`basename $file_name`.info >NIL:
wait 1
echo "xdotool mousemove 1 1 click --repeat 3 1 key F5">Home:.icarosd/runme
EOF
chmod +t $file_name
chmod a+x $file_name
echo chmod +t $file_name >>/tmp/log


icon_name_amiga=`basename ${icon_name/.png/.info}`

cp $icon_name $desktop/$icon_name_amiga 
echo cp $icon_name $desktop/$icon_name_amiga  >>/tmp/log

xdotool mousemove 1 1 click --repeat 3 1 key F5

echo $active_window >>/tmp/log
echo $pid>>/tmp/log 
echo $process_name>>/tmp/log
echo $window_name>>/tmp/log
echo $icon_name>>/tmp/log
echo $file_name >>/tmp/log
#echo icon=${icon_name/.png/.info} >>/tmp/log
echo $icon_name_amiga >>/tmp/log
