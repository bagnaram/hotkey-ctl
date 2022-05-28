#!/usr/bin/env zsh

#THEME=`gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'"`
THEME=Adwaita
ICON_NAME=/usr/share/icons/$THEME/48x48/status/night-light-symbolic.symbolic.png
APP_ID=`basename $0`
TMP=/tmp/$APP_ID-notification-id

percentage() {
  mybrightness=$(( `cat /sys/class/backlight/intel_backlight/brightness` * 100 / `cat /sys/class/backlight/intel_backlight/max_brightness` ))

  progress=""
  k=$(( $mybrightness / 10))
  progress="["
  for ((i = 0 ; i <= k; i++)); do progress="$progress#"; done
  for ((j = i ; j <= 10 ; j++)); do progress="$progress "; done
  progress="$progress] "

}


NID=$(<$TMP)
if [[ $NID == "" ]]; then
  echo 0 > $TMP; NID=0
fi

if [ "$1" = "up" ]
then
  light -A 10
  VAL=`light | awk '{print int($1+0.5)}'`
  NID=`notify-send "Brightness" -a $APP_ID -i $ICON_NAME -h int:value:$VAL $VAL% -p -r $NID`
  echo $NID > $TMP
elif [ "$1" = "down" ]
then
  light -U 10
  VAL=`light | awk '{print int($1+0.5)}'`
  NID=`notify-send "Brightness" -a $APP_ID -i $ICON_NAME -h int:value:$VAL $VAL% -p -r $NID`
  echo $NID > $TMP
else
  echo "Expecting control arguments \"up\" or \"down\"."
fi
