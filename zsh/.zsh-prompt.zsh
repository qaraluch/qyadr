# My 1
# PS1="[%# %n@%m ] %~ λ "
PS1="[%#]%(1j.[%j].)%\[ %n@%m ] %{%F{cyan}%~%} %(?.%F{green}λ.%F{red}λ)%f "

# helper function to add empty line before prompt redrawc
precmd() { print "" }

# Default oh-my-zsh:
# PS1="%n@%m:%~%# "