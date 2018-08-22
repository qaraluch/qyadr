# ZSH terminal helpers and utils functions
# dependencies:
# ???

# From zsh-pony
zle-insert-last-typed-word() { 
  zle insert-last-word -- 0 -1
};
zle -N zle-insert-last-typed-word;
