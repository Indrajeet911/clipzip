#!/bin/bash

bindir="$(dirname "$(readlink -fm "$0")")"
channels="$@"
echo "${channels[0]}"
if [ -z "${channels[0]}" ]; then
   echo "script requires >=1 argument-- channels, but script got empty argument."
   exit 5
fi

cd "${bindir}"



for channel in ${channels}
do


	echo "the channel is ${channel} and we are at path ${PWD}"
	xterm -e "node ./clipzip.js all -c ${channel}"

	# jenk way of running in the other possible DISPLAY
	# in the case that DISPLAY :1 was not the correct desktop
	# this works around an issue in Pop_OS! which makes the DISPLAY
	# one of :0 or :1 but most likely :1
	if [[ $? -ne 0 ]]; then
		echo "LUL, the display is not ${DISPLAY} today."
		DISPLAY=:0 xterm -e "node ./clipzip.js all -c ${channel}"
	fi

	#node ./clipzip.js all -c "${channel}"
done









