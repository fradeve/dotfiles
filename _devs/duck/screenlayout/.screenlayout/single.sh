#!/bin/sh
xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
xrandr --addmode eDP-1 "1680x1050_60.00"
xrandr --output VIRTUAL1 --off \
    --output eDP-1 --mode "1680x1050_60.00" --pos 0x0 --rotate normal \
    --output DP1 --off \
    --output HDMI2 --off \
    --output HDMI1 --off \
    --output DP2 --off
feh --bg-fill /home/fradeve/.wallpaper.jpg
killall lemonbar
killall i3_lemonbar.sh
sleep3
sh /home/fradeve/.config/i3/lemonbar/i3_lemonbar.sh
