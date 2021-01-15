#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
#THEME=`gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'"`
THEME=Adwaita

ICON_NAME=/usr/share/icons/$THEME/scalable/status/audio-volume-high-symbolic.svg

percentage() {

  progress=""
  k=$(( $myvolume / 10))
  progress="["
  for ((i = 0 ; i < k; i++)); do progress="$progress#"; done
  for ((j = i ; j < 10 ; j++)); do progress="$progress "; done
  progress="$progress] "

}

while [[ $# > 0 ]]
do
key="$1"

case $key in
    pony)
    PULSE=true
    ;;
    up)
    DIR="up"
    ;;
    down)
    DIR="down"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
shift
done


if [ "${DIR}" = "up" ]
then
  if [ "$PULSE" = true ]
  then
    pactl set-sink-volume 0 +5%
    myvolume=`ponymix get-volume`
  else
    amixer set -N Master 5%+ -N unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  percentage
  #$SCRIPTPATH/notify-send.sh/notify-send.sh "Volume: $myvolume\n$progress" --replace-file=/tmp/volumenotification -i /usr/share/icons/$THEME/48x48/notifications/notification-audio-volume-high.svg -h string:private-synchronous:volume &
  $SCRIPTPATH/notify-send.sh/notify-send.sh "$myvolume" --replace-file=/tmp/volumenotification -i "$ICON_NAME" -t 2000 -h int:value:"$myvolume" -h string:synchronous:volume
  paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
elif [ "${DIR}" = "down" ]
then
  if [ "$PULSE" = true ]
  then
    pactl set-sink-volume 0 -5%
    myvolume=`ponymix get-volume`
  else
    amixer set Master 5%- -N unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  percentage
  $SCRIPTPATH/notify-send.sh/notify-send.sh "$myvolume" --replace-file=/tmp/volumenotification -i "$ICON_NAME" -t 2000 -h int:value:"$myvolume" -h string:synchronous:volume
  paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
fi

