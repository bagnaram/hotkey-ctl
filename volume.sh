#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

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
    ponymix -c broadwell-rt286 increase 5% 
    myvolume=`ponymix get-volume`
  else
    amixer set Master 5%+ unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  percentage
  $SCRIPTPATH/notify-send.sh/notify-send.sh "Volume: %p\n$progress" --replace-file=/tmp/volumenotification -i /usr/share/icons/gnome/48x48/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:private-synchronous:myvolume &
  aplay $SCRIPTPATH/pop.wav
elif [ "${DIR}" = "down" ]
then
  if [ "$PULSE" = true ]
  then
    ponymix -c broadwell-rt286 decrease 5% 
    myvolume=`ponymix get-volume`
  else
    amixer set Master 5%- unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  percentage
  $SCRIPTPATH/notify-send.sh/notify-send.sh "Volume: %p\n$progress" --replace-file=/tmp/volumenotification -i /usr/share/icons/gnome/48x48/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:private-synchronous:volume &
  aplay $SCRIPTPATH/pop.wav
fi

