#!/usr/bin/env zsh
PS4='+%D{%s.%9.}:%N:%i>'
set -ex 
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
  notify-send.sh --replace-file=/tmp/volumenotification -i "$ICON_NAME" -t 2000 "Volume" -h int:value:"$(pamixer -i 5 --get-volume)" -h string:synchronous:volume
   pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
elif [ "${DIR}" = "down" ]
then
  notify-send.sh --replace-file=/tmp/volumenotification -i "$ICON_NAME" -t 2000 "Volume" -h int:value:"$(pamixer -d 5 --get-volume)" -h string:synchronous:volume
   pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
fi

