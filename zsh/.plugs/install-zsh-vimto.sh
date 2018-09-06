# Home URL: [laurenkt/zsh-vimto: Improved zsh vim mode (bindkey -v) plugin](https://github.com/laurenkt/zsh-vimto)

# Switch
export PLUG_DO_INSTALL_ZSH_VIMTO='Y'

# Vars 
export PLUG_NAME_ZSH_VIMTO='zsh-vimto'
export PLUG_FILE_NAME_ZSH_VIMTO='zsh-vimto.zsh'
export PLUG_GIT_URL_ZSH_VIMTO='https://github.com/laurenkt/zsh-vimto.git'

# Computed Vars
export D_PLUG_ZSH_VIMTO="${D_PLUGS}-cache/${PLUG_NAME_ZSH_VIMTO}" 
export PLUG_CMD_INSTALLATION_ZSH_VIMTO="git clone --depth 1 ${PLUG_GIT_URL_ZSH_VIMTO} ${D_PLUG_ZSH_VIMTO}"
export PLUG_CMD_SOURCE_ZSH_VIMTO="source ${D_PLUG_ZSH_VIMTO}/${PLUG_FILE_NAME_ZSH_VIMTO}"

# First time installation
zsh-plug-install-zsh-vimto() {
    if [[ ! -d $D_PLUG_ZSH_VIMTO ]]; then
        echoIt "It seemed you have no installed a '${C_Y}${PLUG_NAME_ZSH_VIMTO}${C_E}' plugin." "$I_W"
        echoIt "About to install it..."
        eval $PLUG_CMD_INSTALLATION_ZSH_VIMTO
        echoDone
    fi
}

if switchY $PLUG_DO_INSTALL_ZSH_VIMTO ; then
    zsh-plug-install-zsh-vimto
fi

# Uninstall
zsh-plug-uninstall-zsh-vimto() {
    if [[ -d $D_PLUG_ZSH_VIMTO ]]; then
        echoIt "About to uninstall a '${C_Y}${PLUG_NAME_ZSH_VIMTO}${C_E}' plugin." "$I_W"
        rm -rf $D_PLUG_ZSH_VIMTO
        echoDone
    fi
}

if ! switchY $PLUG_DO_INSTALL_ZSH_VIMTO ; then
    zsh-plug-uninstall-zsh-vimto
fi


# Source
if switchY $PLUG_DO_INSTALL_ZSH_VIMTO && [[ -d $D_PLUG_ZSH_VIMTO ]]; then
    eval $PLUG_CMD_SOURCE_ZSH_VIMTO
fi

# Plugin config