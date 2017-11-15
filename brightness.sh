#!/bin/bash

cd ~/hotkey-ctl

percentage() {
  mybrightness=$(( `cat /sys/class/backlight/intel_backlight/brightness` * 100 / `cat /sys/class/backlight/intel_backlight/max_brightness` ))

  progress=""
  k=$(( $mybrightness / 10))
  progress="["
  for ((i = 0 ; i <= k; i++)); do progress="$progress#"; done
  for ((j = i ; j <= 10 ; j++)); do progress="$progress "; done
  progress="$progress] "

}


if [ "$1" = "up" ]
then
  light -A 10
  percentage

  notify-send.sh/notify-send.sh "Brightness: %p\n$progress" --replace-file=/tmp/brightnessnotification -i /usr/share/icons/HighContrast/48x48/status/display-brightness.png -h int:value:$(( $mybrightness )) -h string:private-synchronous:brightness &
elif [ "$1" = "down" ]
then
  light -U 10
  percentage

  notify-send.sh/notify-send.sh "Brightness: %p\n$progress" --replace-file=/tmp/brightnessnotification -i /usr/share/icons/HighContrast/48x48/status/display-brightness.png -h int:value:$(( $mybrightness )) -h string:private-synchronous:brightness &
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
