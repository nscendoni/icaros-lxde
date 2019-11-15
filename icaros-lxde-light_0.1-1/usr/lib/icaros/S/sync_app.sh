#!/bin/bash

destination_folder=/usr/lib/icaros/Linux

application_list=`find /usr/share/applications/ -name *.desktop`
for application in $application_list
do
	echo $application
	application_name=`grep -e "^Name=" $application |head -1| sed s/Name=//`
	application_exe=`grep -e "^Exec=" $application | head -1 | sed s/Exec=//`
	icon_name=`grep -e "^Icon=" $application | head -1 | sed s/Icon=//`
	icon_file=`/usr/lib/icaros/S/find_icon.py $icon_name`
	convert $icon_file -format png -resize 48x48\> "$destination_folder/$application_name".png
	mv "$destination_folder/$application_name".png "$destination_folder/$application_name".info
	
	cp /usr/lib/icaros/System/Hosted/hbtemplate "$destination_folder/$application_name"
	sed -i s/_COMMAND_/$(basename $application_exe)/ "$destination_folder/$application_name"
	# absolute_path=$(basename $application_exe)
	fullpath=`which $absolute_path`
	sed -i s@_FULLPATH_@$fullpath@ "$destination_folder/$application_name"
	parameters=`echo $application_exe|sed s/.*\ //| sed s/%.//`
	sed -i s/_PARAMETERS_/$parameters/ "$destination_folder/$application_name"
	chmod a+rxt "$destination_folder/$application_name"
done
