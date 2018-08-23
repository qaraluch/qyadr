# ZSH terminal helpers and utils functions
# dependencies:
# ???

# From zsh-pony
zle-insert-last-typed-word() { 
  zle insert-last-word -- 0 -1
};
zle -N zle-insert-last-typed-word;

# From zsh-pony
zle-slash-backward-kill-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-kill-word
}
zle -N zle-slash-backward-kill-word

# From .grml.org
# Useful to add options.
function zle-jump-after-first-word () {
  local WORDS
  WORDS=(${(z)BUFFER})
  if (( ${#WORDS} <= 1 )) ; then
      CURSOR=${#BUFFER}
  else
      CURSOR=${#${WORDS[1]}}
  fi
}
zle -N zle-jump-after-first-word