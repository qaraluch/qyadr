# From oh-my-zsh
function git-get-current-branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

setopt PROMPT_SUBST             # Set prompt substitution

# PROMPT - My First 
PROMPT='%(1j.[%j].)[ %(!.%{%F{red}%}%n%{%f%}.%{%F{white}%}%}%n%{%f%})@%m ] %{%F{cyan}%}%~%{%f%} %{%F{010}%}$(git-get-current-branch)%{%f%} %(?.%{%F{green}%}λ %{%f%}.%{%F{red}%}λ %{%f%})'

# PROMPT - Default oh-my-zsh
# PS1="%n@%m:%~%# "
