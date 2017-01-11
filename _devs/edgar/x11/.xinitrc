#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

syndaemon -t -k -i 1 -d &
exec /usr/bin/setxkbmap -model thinkpad -layout gb &
feh --bg-scale /home/fradeve/.wallpaper.jpg
exec volumeicon &
eval $(gpg-agent --daemon)
exec i3
[ ! -s ~/.mpd/pid ] && mpd
