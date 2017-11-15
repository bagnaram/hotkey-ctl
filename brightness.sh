#!/bin/bash

mybrightness=$(( `cat /sys/class/backlight/intel_backlight/brightness` * 100 / `cat /sys/class/backlight/intel_backlight/max_brightness` ))

  progress=""
k=$(( $(( $mybrightness + 10 )) / 10))
    progress="["
    for ((i = 0 ; i <= k; i++)); do progress="$progress#"; done
    for ((j = i ; j <= 10 ; j++)); do progress="$progress "; done
    progress="$progress] "

if [ "$1" = "up" ]
then
  light -A 10



  notify-send "Brightness: %p\n$progress" -i /usr/share/icons/HighContrast/48x48/status/display-brightness.png -h int:value:$(( $mybrightness + 10 )) -h string:x-canonical-private-synchronous:brightness &
elif [ "$1" = "down" ]
then
  light -U 10
  notify-send "Brightness: %p\n$progress" -i /usr/share/icons/HighContrast/48x48/status/display-brightness.png -h int:value:$(( $mybrightness - 10 )) -h string:x-canonical-private-synchronous:brightness &
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
