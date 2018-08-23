# Home URL: [zsh-users/zsh-syntax-highlighting: Fish shell like syntax highlighting for Zsh.](https://github.com/zsh-users/zsh-syntax-highlighting)

# Switch
export PLUG_DO_INSTALL_ZSH_SYNTAX_HIGHLIGHTING='Y'

# Vars 
export PLUG_NAME_ZSH_SYNTAX_HIGHLIGHTING='zsh-syntax-highlighting'
export PLUG_FILE_NAME_ZSH_SYNTAX_HIGHLIGHTING='zsh-syntax-highlighting.zsh'
export PLUG_GIT_URL_ZSH_SYNTAX_HIGHLIGHTING='https://github.com/zsh-users/zsh-syntax-highlighting.git'

# Computed Vars
export D_PLUG_ZSH_SYNTAX_HIGHLIGHTING="${D_PLUGS}-cache/${PLUG_NAME_ZSH_SYNTAX_HIGHLIGHTING}" 
export PLUG_CMD_INSTALLATION_ZSH_SYNTAX_HIGHLIGHTING="git clone --depth 1 ${PLUG_GIT_URL_ZSH_SYNTAX_HIGHLIGHTING} ${D_PLUG_ZSH_SYNTAX_HIGHLIGHTING}"
export PLUG_CMD_SOURCE_ZSH_SYNTAX_HIGHLIGHTING="source ${D_PLUG_ZSH_SYNTAX_HIGHLIGHTING}/${PLUG_FILE_NAME_ZSH_SYNTAX_HIGHLIGHTING}"

# First time installation
zsh-plug-install-zsh-syntax-highlighting () {
    if [[ ! -d $D_PLUG_ZSH_SYNTAX_HIGHLIGHTING ]]; then
        echoIt "It seemed you have no installed a '${C_Y}${PLUG_NAME_ZSH_SYNTAX_HIGHLIGHTING}${C_E}' plugin." "$I_W"
        echoIt "About to install it..."
        eval $PLUG_CMD_INSTALLATION_ZSH_SYNTAX_HIGHLIGHTING
        echoDone
    fi
}

if switchY $PLUG_DO_INSTALL_ZSH_SYNTAX_HIGHLIGHTING ; then
    zsh-plug-install-zsh-syntax-highlighting
fi

# Uninstall
zsh-plug-uninstall-zsh-syntax-highlighting () {
    if [[ -d $D_PLUG_ZSH_SYNTAX_HIGHLIGHTING ]]; then
        echoIt "About to uninstall a '${C_Y}${PLUG_NAME_ZSH_SYNTAX_HIGHLIGHTING}${C_E}' plugin." "$I_W"
        rm -rf $D_PLUG_ZSH_SYNTAX_HIGHLIGHTING
        echoDone
    fi
}

if ! switchY $PLUG_DO_INSTALL_ZSH_SYNTAX_HIGHLIGHTING ; then
    zsh-plug-uninstall-zsh-syntax-highlighting
fi


# Source
# zsh-syntax-highlighting.zsh must be sourced at the end of the .zshrc file
if switchY $PLUG_DO_INSTALL_ZSH_SYNTAX_HIGHLIGHTING && [[ -d $D_PLUG_ZSH_SYNTAX_HIGHLIGHTING ]]; then
    eval $PLUG_CMD_SOURCE_ZSH_SYNTAX_HIGHLIGHTING
fi

# Plugin config
# Ls all colors run: zsh-spectrum-ls
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -xA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=191'                      # greenish 
ZSH_HIGHLIGHT_STYLES[arg0]='fg=191'                       
ZSH_HIGHLIGHT_STYLES[command]='fg=191'          
ZSH_HIGHLIGHT_STYLES[function]='fg=191'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=230'       # orangish
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=230'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'                      
ZSH_HIGHLIGHT_STYLES[comment]='fg=225'                    # light purplish
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=yellow'

