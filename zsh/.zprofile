# Path
[[ ":$PATH:" != *":${HOME}/.scripts/"* ]] && PATH="$PATH:$(du -L "$HOME/.scripts" | cut -f2 | tr '\n' ':' | rev | cut -c 2- | rev)"
  # also removes inconvenient trailing colon

export VIMRC="${HOME}/.vimrc"
