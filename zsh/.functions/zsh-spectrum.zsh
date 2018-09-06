#! /bin/zsh
# A script to make using 256 colors in zsh less painful.
# Copied from [oh-my-zsh/spectrum.zsh at master · robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh#L22)

typeset -AHg FX C_FG C_BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    C_FG[$color]="%{[38;5;${color}m%}"
    C_BG[$color]="%{[48;5;${color}m%}"
done

export C_RESET="%{[00m%}"

# Show all 256 colors with color number
zsh-spectrum-ls() {
  local ZSH_SPECTRUM_TEXT=${1:-Make using 256 colors in zsh less painful}
  for code in {000..255}; do
    print -P -- "$code: %{$C_FG[$code]%}$ZSH_SPECTRUM_TEXT%{$C_RESET%}"
  done
}

# Show all 256 colors where the background is set to specific color
zsh-spectrum-ls-bg() {
  local ZSH_SPECTRUM_TEXT=${1:-Make using 256 colors in zsh less painful}
  for code in {000..255}; do
    print -P -- "$code: %{$C_BG[$code]%}$ZSH_SPECTRUM_TEXT%{$C_RESET%}"
  done
}