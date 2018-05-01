#!/usr/bin/env python

import gi
import sys
import os
import math
gi.require_version('Gtk', '3.0')

dir_path = os.path.dirname(os.path.realpath(__file__))

from gi.repository import Gtk
icon_theme = Gtk.IconTheme.get_default()
icon_info = icon_theme.lookup_icon("video-display", 48, 0)
print(icon_info.get_filename())

def percentage():
    f=open('/sys/class/backlight/intel_backlight/brightness', 'r')
    mybrightness=f.read()
    f.close()


    f=open('/sys/class/backlight/intel_backlight/max_brightness', 'r')
    maxbrightness=f.read()
    f.close()

    mybrightness=(int(mybrightness) * 100 / int(maxbrightness))
    print(mybrightness)
    mybrightness = int(math.ceil(mybrightness / 10.0)) 
    k=mybrightness
    print(k)

    progress=""
    threashold=0
    for i in range(0,k):
        progress+="#"
        threashold=i
    for j in range(threashold,9):
        progress+=" "
    progress="[" + progress + "]"
    return(progress)

if sys.argv[1] == "up":
    os.system("light -A 10")
elif sys.argv[1] == "down":
    os.system("light -U 10")
else:
    print('Expecting control arguments "up" or "down"')
    sys.exit()

string = percentage()

cmd = dir_path + '/notify-send.sh/notify-send.sh "Brightness:\n' + string + '" --replace-file=/tmp/brightnessnotification -i ' + icon_info.get_filename() + ' -h string:private-synchronous:brightness &'
os.system(cmd)

