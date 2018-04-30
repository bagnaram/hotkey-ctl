## hotkey-ctl

## Description

hotkey-ctl is a collection of scripts to display notifications for volume and brightness events. It is configured to be used with a libnotify compliant client.


## Installation

### Dependencies

hotkey-ctl requires

- notify-send.sh (provided as submodule)
- dunst https://dunst-project.org/
- libnotify
- ponymix http://github.com/falconindy/ponymix
- light https://github.com/haikarainen/light

### Cloning

```
git clone https://github.com/bagnaram/hotkey-ctl.git
```

### Setup

For i3wm, you can configure the following lines in `~/.config/i3/config`

```
# audio controls
bindsym XF86AudioRaiseVolume exec ~/hotkey-ctl/volume.sh pony up   # increase sound volume
bindsym XF86AudioLowerVolume exec ~/hotkey-ctl/volume.sh pony down # decrease sound volume
bindsym XF86AudioMute exec ponymix toggle                          # mute sound
bindsym XF86AudioMicMute exec amixer set Capture toggle            # mute mic

# screen brightness controls
bindsym XF86MonBrightnessUp exec ~/hotkey-ctl/brightness.sh up     # increase screen brightness
bindsym XF86MonBrightnessDown exec ~/hotkey-ctl/brightness.sh down # decrease screen brightness
```


## Maintainers

Matt Bagnara <mbagnara@redhat.com>

## Author

Matt Bagnara <mbagnara@redhat.com>

