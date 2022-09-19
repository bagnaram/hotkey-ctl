#!/usr/bin/env zsh

ICON_NAME=multimedia-volume-control
APP_ID=`basename $0`
TMP=/tmp/$APP_ID-notification-id
SOUND=/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

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
    PONYMIX=true
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
if [[ $NID == "" ]]; then
  echo 0 > $TMP; NID=0
fi

notify() {notify-send "volume" -a $APP_ID -p -i $ICON_NAME -t 2000 -h int:value:$VOL $VOL% -r $NID}

if [ "${DIR}" = "up" ]
then
  VOL=`pamixer -i 5 --get-volume`
  NID=$(notify)
  echo $NID > $TMP
  pw-play $SOUND
elif [ "${DIR}" = "down" ]
then
  VOL=`pamixer -d 5 --get-volume`
  NID=$(notify)
  echo $NID > $TMP
  pw-play $SOUND
fi
