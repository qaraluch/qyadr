#!/bin/sh

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

xset r rate 200 50
xcompmgr &            # For window transparency / alpha
sxhkd -m 1 &		      # Bind keys with sxhkd
setxkbmap -layout pl  # Polish keyboard layout

# Window manager
exec i3
