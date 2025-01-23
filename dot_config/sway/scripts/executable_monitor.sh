#!/bin/bash

if swaymsg -t get_outputs | grep "HDMI-A-1"; then
    swaymsg output eDP-2 disable
    swaymsg output HDMI-A-1 resolution 1920x1080 position 0 0 bg /home/arunav/Pictures/wallpapers/boy-art.jpg fill
else
    swaymsg output eDP-2 resolution 1920x1080 position 0 0 bg /home/arunav/Pictures/wallpapers/boy-art.jpg fill
fi
