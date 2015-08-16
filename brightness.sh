#!/bin/bash

mybrightness=$(( `cat /sys/class/backlight/intel_backlight/brightness` * 100 / 1000 ))

if [ "$1" = "up" ]
then
  xbacklight +10
  notify-send " " -i notification-display-brightness-low -h int:value:$(( $mybrightness + 10 )) -h string:x-canonical-private-synchronous:brightness &
elif [ "$1" = "down" ]
then
  xbacklight -10
  notify-send " " -i notification-display-brightness-low -h int:value:$(( $mybrightness - 10 )) -h string:x-canonical-private-synchronous:brightness &
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
