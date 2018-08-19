setopt PROMPT_SUBST             # Set prompt substitution

# PROMPT - My First 
PROMPT='%(1j.[%j].)[ %(!.%{%F{red}%}%n%{%f%}.%{%F{white}%}%}%n%{%f%})@%m ] %{%F{cyan}%}%~%{%f%} %{%F{010}%}$(git-get-current-branch)%{%f%} %(?.%{%F{green}%}λ %{%f%}.%{%F{red}%}λ %{%f%})'

# PROMPT - Default oh-my-zsh
# PS1="%n@%m:%~%# "
