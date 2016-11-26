#!/bin/sh
xrandr --output VIRTUAL1 --off \
    --output eDP1 --mode 1680x1050 --pos 0x1080 --rotate normal \
    --output DP1 --off \
    --output HDMI2 --off \
    --output HDMI1 --off \
    --output DP2 --primary --mode 1920x1080 --pos 0x0 --rotate normal
feh --bg-fill /home/fradeve/.wallpaper.jpg
killall lemonbar
killall i3_lemonbar.sh
sleep3
sh /home/fradeve/.config/i3/lemonbar/i3_lemonbar.sh
