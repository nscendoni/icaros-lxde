#!/bin/bash 

destination_folder=/usr/lib/icaros/Linux

application_list=`find /usr/share/applications/ -name *.desktop`
# application_list=/usr/share/applications/lxterminal.desktop
for application in $application_list
do
	echo $application
	application_name=`grep -e "^Name=" $application | head -1 | sed s/Name=//`
	echo application_name=$application_name
	# Extract the Exec lines with parameter. Remove the %. that is not a parameter
	application_exe=`grep -e "^Exec=" $application | head -1 | sed s/Exec=//`

	# Extract from the Exec line the parameters
        parameters=`echo $application_exe|sed s/.*\ //| head -1 | sed s/%.//`

	# Remove from Exec line the paramters
	application_exe=`grep -e "^Exec=" $application | head -1 | sed s/Exec=//|sed s/\ .*//`
	parameters=`echo $parameters|sed s@$application_exe@@`
	echo application_exe=$application_exe
	echo parameters=$parameters

	icon_name=`grep -e "^Icon=" $application |head -1 | sed s/Icon=//`
	echo icon_name=$icon_name
	if [ -z ${icon_name} ] 
	then
		echo continue
		continue
	fi
	
	icon_file=`/usr/lib/icaros/S/find_icon.py $icon_name`
	convert $icon_file -format png -resize 48x48\> "$destination_folder/$application_name".png
	mv "$destination_folder/$application_name".png "$destination_folder/$application_name".info
	
	cp /usr/lib/icaros/System/Hosted/hbtemplate "$destination_folder/$application_name" 
	sed -i s@_COMMAND_@@ "$destination_folder/$application_name"
	sed -i s@_FULLPATH_@$application_exe@ "$destination_folder/$application_name"
        sed -i s@_PARAMETERS_@$parameters@ "$destination_folder/$application_name"

#	cat >"$destination_folder/$application_name" <<EOF
#echo "$application_exe" >Home:.icarosd/runme
#EOF
	chmod a+rxt "$destination_folder/$application_name"
done
