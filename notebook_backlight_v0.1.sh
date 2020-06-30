#! /bin/bash

#date >> /home/larce/Pictures/web_shot/log

colors=$(fswebcam -d /dev/video0 -r 1024x768 -q - | convert - -resize 1x1  txt:- | sed -n 2p | sed 's/.*srgb(\([0-9][0-9]*,[0-9][0-9]*,[0-9][0-9]*\))/\1/')
IFS=',' read -ra bright_array <<< "$colors"

battery=$(acpi)
IFS=',' read -ra batt_array <<< "$battery"
battery=$(echo ${batt_array[1]} | sed 's/%//')

ac_stat=$(acpi -a)
IFS=':' read -ra ac_array <<< "$ac_stat"
if [[ ${ac_array[1]} == " off-line" ]]; then
	add_bright=150
else
	add_bright=200
fi

min_batt=40

if [[ $battery -lt $min_batt ]]; then
	bright=$(echo "100.0/765.0*(${bright_array[1]:4} + $add_bright / $min_batt * $battery)" | bc -l | sed 's/\([0-9]*\).*/\1/')
else
	bright=$(echo "100.0/765.0*(${bright_array[1]:4} + $add_bright)" | bc -l | sed 's/\([0-9]*\).*/\1/')
fi


# Check for minimal brightness value
if [[ $bright -lt 10 ]]; then
bright=15
fi

xbacklight  -set "$bright"% -time 1000

xbacklight -get | sed 's/\([0-9]*\).*/\1%/'


