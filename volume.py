#!/usr/bin/env python

import gi
import sys
import subprocess
import os
import math
import argparse
gi.require_version('Gtk', '3.0')

dir_path = os.path.dirname(os.path.realpath(__file__))

from gi.repository import Gtk
icon_theme = Gtk.IconTheme.get_default()
icon_info = icon_theme.lookup_icon("audio-volume-high", 48, 0)
print(icon_info.get_filename())

parser = argparse.ArgumentParser(description='Modify system volume')
parser.add_argument('--pony', action='store_true' , help='To use pulseaudio?')
parser.add_argument('--dir', action='store', choices=['up','down'])
args=parser.parse_args()
pulse=args.pony
direction=args.dir


myvolume=50

def percentage(volume):


    volume = int(math.ceil(int(volume) / 10.0)) 
    k=volume

    progress=""
    threashold=0
    for i in range(0,k):
        progress+="#"
        threashold=i
    for j in range(threashold,9):
        progress+=" "
    progress="[" + progress + "]"
    return(progress)


if direction == "up":
    if pulse == True:
        os.system('ponymix -c broadwell-rt286 increase 5%')
        proc = subprocess.Popen('ponymix get-volume', shell=True, stdout=subprocess.PIPE)
        myvolume = proc.stdout.read()
    if pulse == False:
        os.system('amixer set Master 5%+ unmute')
        proc = subprocess.Popen('amixer get "Master",0 | gawk "match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}"', shell=True, stdout=subprocess.PIPE)
        myvolume = proc.stdout.read()
elif direction == "down":
    if pulse == True:
        os.system('ponymix -c broadwell-rt286 decrease 5%')
        proc = subprocess.Popen('ponymix get-volume', shell=True, stdout=subprocess.PIPE)
        myvolume = proc.stdout.read()
    if pulse == False:
        os.system('amixer set Master 5%- unmute')
        proc = subprocess.Popen('amixer get "Master",0 | gawk "match($0, /\[([0-9]*)%\]/, m) {print m[1]; exit;}"',  shell=True, stdout=subprocess.PIPE)
        myvolume = proc.stdout.read()
else:
    print('Expecting control arguments "up" or "down"')
    sys.exit()


string = percentage(myvolume)

cmd = dir_path + '/notify-send.sh/notify-send.sh "Volume:\n' + string + '" --replace-file=/tmp/volumenotification -i ' + icon_info.get_filename() + ' -h string:private-synchronous:volume &'
os.system(cmd)
cmd = "aplay " + dir_path + "/pop.wav"
os.system(cmd)

