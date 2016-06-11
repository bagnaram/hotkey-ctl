#!/bin/bash

cd ~/hotkey-ctl

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
    myvolume=`ponymix -c broadwell-rt286 get-volume`
  else
    amixer set Master 5%+ unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  notify-send " " -i /usr/share/icons/gnome/48x48/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:x-canonical-private-synchronous:myvolume &
  aplay ./pop.wav
elif [ "${DIR}" = "down" ]
then
  if [ "$PULSE" = true ]
  then
    ponymix -c broadwell-rt286 decrease 5% 
    myvolume=`ponymix -c broadwell-rt286 get-volume`
  else
    amixer set Master 5%- unmute
    myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}'`
  fi
  notify-send " " -i /usr/share/icons/gnome/48x48/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:x-canonical-private-synchronous:volume &
  aplay ./pop.wav
fi
