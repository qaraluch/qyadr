# Path
[[ ":$PATH:" != *":${HOME}/.scripts:"* ]] && PATH="$PATH:$(du -L "$HOME/.scripts/" | cut -f2 | tr '\n' ':')"

# [4 Arch] Start X server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
