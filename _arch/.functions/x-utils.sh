# Wallpaper
# copy and set
set-wallpaper() {
  local wallPath="${HOME}/.wallpaper"
  [ ! -z "$1" ] && cp "$1" "${wallPath}"
  feh --bg-scale "${wallPath}"
  # && notify-send -i "$HOME/./wall.png" "Wallpaper changed."
  # TODO: maybe: xwallpaper ?
}