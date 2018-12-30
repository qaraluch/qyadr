# ZSH terminal helpers and utils functions
# dependencies:
# ???

# zle utils
_zle-init-widget() {                # when init widget, save what is typed in command line
  if [[ -n $1 ]]; then
    BUFFER="$1 "
    CURSOR=$#BUFFER
    zle redisplay
  fi
}

# from fzf-widgets
_zle-insert() {
  local -a items
  IFS=$'\n' items=(`cat`)
  if [[ -n $items ]]; then
    for item in $items; do
      if [[ $1 = -q ]]; then
        # quote special characters with backslashes
        BUFFER+="$item:q:gs/\\~/~/ "
      else
        BUFFER+="$item "
      fi
    done
    BUFFER="${BUFFER% } "
    CURSOR=$#BUFFER
    zle redisplay
  else
    _zle-clear
  fi
}

_zle-clear() {
  BUFFER=""
  CURSOR=$#BUFFER
  zle redisplay
}

# From zsh-pony
zle-insert-last-typed-word() {
  zle insert-last-word -- 0 -1
};

zle -N zle-insert-last-typed-word;

# From zsh-pony
zle-slash-backward-kill-word() {
  local wordChars="${wordChars:s@/@}"
  zle backward-kill-word
}

zle -N zle-slash-backward-kill-word

# From .grml.org
# Useful to add options.
zle-jump-after-first-word() {
  local words
  words=(${(z)BUFFER})
  if (( ${#words} <= 1 )) ; then
      CURSOR=${#BUFFER}
  else
      CURSOR=${#${words[1]}}
  fi
}

zle -N zle-jump-after-first-word