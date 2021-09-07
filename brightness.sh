#!/usr/bin/env zsh

#THEME=`gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'"`
THEME=Adwaita
ICON_NAME=/usr/share/icons/$THEME/48x48/status/night-light-symbolic.symbolic.png
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
  notify-send.sh --replace-file=/tmp/brightnessnotification -i $ICON_NAME "Brightness" -h int:value:"$(light | awk '{print int($1+0.5)}')" -h string:synchronous:brightness
elif [ "$1" = "down" ]
then
  light -U 10
  notify-send.sh --replace-file=/tmp/brightnessnotification -i $ICON_NAME "Brightness" -h int:value:"$(light | awk '{print int($1+0.5)}')" -h string:synchronous:brightness
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
