#!/usr/bin/env zsh
PS4='+%D{%s.%9.}:%N:%i>'
set -ex 
THEME=Adwaita
ICON_NAME=/usr/share/icons/$THEME/scalable/status/audio-volume-high-symbolic.svg
APP_ID=`basename $0`
TMP=/tmp/$APP_ID-notification-id

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

NID=$(<$TMP)

if [ "${DIR}" = "up" ]
then
  VOL=`pamixer -i 5 --get-volume`
  NID=`notify-send "volume" -a $APP_ID -p -i $ICON_NAME -t 2000 -h int:value:$VOL $VOL% -r $NID`
  echo $NID > $TMP
  pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
  #canberra-gtk-play -i audio-volume-change
elif [ "${DIR}" = "down" ]
then
  VOL=`pamixer -d 5 --get-volume`
  NID=`notify-send "volume" -a $APP_ID -p -i $ICON_NAME -t 2000 -h int:value:$VOL $VOL% -r $NID`
  echo $NID > $TMP
  pw-play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
  #canberra-gtk-play -i audio-volume-change
fi

