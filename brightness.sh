#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
THEME=`gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'"`

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

  $SCRIPTPATH/notify-send.sh/notify-send.sh "Brightness: $mybrightness\n$progress" --replace-file=/tmp/brightnessnotification -i /usr/share/icons/$THEME/48x48/notifications/notification-display-brightness.svg -h string:private-synchronous:brightness &
elif [ "$1" = "down" ]
then
  light -U 10
  percentage

  $SCRIPTPATH/notify-send.sh/notify-send.sh "Brightness: $mybrightness\n$progress" --replace-file=/tmp/brightnessnotification -i /usr/share/icons/$THEME/48x48/notifications/notification-display-brightness.svg -h string:private-synchronous:brightness &
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
