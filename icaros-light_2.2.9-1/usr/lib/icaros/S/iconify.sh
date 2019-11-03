#!/bin/bash

echo begin log>/tmp/log

# Configuration
desktop=/usr/lib/icaros/MyWorkspace/Desktop
MyWorkspace=/usr/lib/icaros/MyWorkspace

# Iconify Event - Get informations
active_window=`xdotool getactivewindow`
pid=`xdotool getwindowpid $active_window=`
process_name=`ps -q $pid |grep $pid |awk '{ print $4 }'`

# Search the icon name in .desktop files
desktop_file=`grep -l $process_name /usr/share/applications/*.desktop|head -1`
desktop_icon_name=`grep Icon $desktop_file|sed s/Icon=//`
icon_name=`/usr/lib/icaros/S/find_icon.py $desktop_icon_name`

echo "desktop_file=$desktop_file" >>/tmp/log
echo "icon_name=$icon_name" >>/tmp/log

# icon_name=`/usr/lib/icaros/S/find_icon.py $process_name`

# If icon is already present, append -num to icon
if [[ -e $desktop/$process_name ]] ; then
    i=0
	    while [[ -e $desktop/$process_name-$i ]] ; do
        let i++
    done
    process_name=$process_name-$i
fi

window_name=`xdotool getwindowname $active_window`
#todo: convert file, resize it and manage errors

# Prepare Icaros Script
file_name=$desktop/$process_name
cat >$file_name <<EOF
echo "xdotool windowactivate $active_window">Home:.icarosd/runme
delete MyWorkspace:Desktop/`basename $file_name` >NIL:
delete MyWorkspace:Desktop/`basename $file_name`.info >NIL:
; wait 1
; echo "xdotool mousemove 800 10 click --repeat 3 1 key F5">Home:.icarosd/runme
sh -c "touch MyWorkspace:.refresh"
EOF
chmod +t $file_name
chmod a+x $file_name
echo chmod +t $file_name >>/tmp/log

cp $icon_name $desktop
echo cp $icon_name $desktop >>/tmp/log
base_icon_name=`basename $icon_name`

cd $desktop
convert $base_icon_name -format png -resize 48x48\> $base_icon_name
echo convert $desktop/$base_icon_name -format png -resize 48x48\> $desktop/$base_icon_name >>/tmp/log
# icon_name_amiga=`basename ${process_name}`.info

mv $desktop/`basename $icon_name` $desktop/`basename ${process_name}`.info
echo mv $desktop/`basname $icon_name` $desktop/`basename ${process_name}`.info >>/tmp/log
echo cp $icon_name $desktop/$icon_name_amiga  >>/tmp/log

# Refresh Icaros
#xdotool mousemove 800 10 click --repeat 3 1 key F5
touch $MyWorkspace/.refresh

echo $active_window >>/tmp/log
echo $pid>>/tmp/log 
echo $process_name>>/tmp/log
echo $window_name>>/tmp/log
echo $icon_name>>/tmp/log
echo $file_name >>/tmp/log
#echo icon=${icon_name/.png/.info} >>/tmp/log
echo $icon_name_amiga >>/tmp/log
