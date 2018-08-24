# Home URL: [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf) 

# Switch
export PLUG_DO_INSTALL_FZF='Y'

# Vars 
export PLUG_NAME_FZF='fzf'
export PLUG_FILE_NAME_FZF='install'
export PLUG_GIT_URL_FZF='https://github.com/junegunn/fzf.git'

# Computed Vars
export D_PLUG_FZF="${D_PLUGS}-cache/${PLUG_NAME_FZF}" 
export PLUG_CMD_INSTALLATION_FZF="git clone --depth 1 ${PLUG_GIT_URL_FZF} ${D_PLUG_FZF}"

# First time installation
zsh-plug-install-fzf () {
    if [[ ! -d $D_PLUG_FZF ]]; then
        echoIt "It seemed you have no installed a '${C_Y}${PLUG_NAME_FZF}${C_E}'." "$I_W"
        echoIt "About to install it..."
        eval $PLUG_CMD_INSTALLATION_FZF
        echoDone
    fi
}

if switchY $PLUG_DO_INSTALL_FZF ; then
    zsh-plug-install-fzf
fi

# Uninstall
zsh-plug-uninstall-fzf () {
    if [[ -d $D_PLUG_FZF ]]; then
        echoIt "About to uninstall a '${C_Y}${PLUG_NAME_FZF}${C_E}'." "$I_W"
        rm -rf $D_PLUG_FZF
        echoDone
    fi
}

if ! switchY $PLUG_DO_INSTALL_FZF ; then
    zsh-plug-uninstall-fzf
fi

# Fzf intaller (one time)
if switchY $PLUG_DO_INSTALL_FZF && [[ ! -f "${D_PLUG_FZF}/bin/fzf" ]]; then
  bash ${D_PLUG_FZF}/${PLUG_FILE_NAME_FZF} --no-bash --no-zsh --no-fish --no-update-rc
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == */fzf/bin* ]]; then
  export PATH="$PATH:${D_PLUG_FZF}/bin"
fi

# Auto-completion
# ---------------
# if interactive shell add completion
[[ $- == *i* ]] && source "${D_PLUG_FZF}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${D_PLUG_FZF}/shell/key-bindings.zsh"

# Options
# export FZF_DEFAULT_OPTS='
#     --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
#     --color info:108,prompt:109,spinner:108,pointer:168,marker:168
# '

export FZF_DEFAULT_OPTS='
    --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
    --color info:144,prompt:161,spinner:135,pointer:135,marker:118
'