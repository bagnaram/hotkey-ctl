#!/bin/bash


if [ "$1" = "up" ]
then
  amixer set Master 5%+ unmute
  myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1];}'`
  notify-send " " -i /usr/share/icons/gnome/32x32/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:x-canonical-private-synchronous:myvolume &
elif [ "$1" = "down" ]
then
  amixer set Master 5%- unmute
  myvolume=`amixer get 'Master',0 | gawk 'match($0, /\[([0-9]*)%\]/, m) {print m[1];}'`
  notify-send " " -i /usr/share/icons/gnome/32x32/apps/multimedia-volume-control.png -h int:value:$myvolume -h string:x-canonical-private-synchronous:volume &
fi
