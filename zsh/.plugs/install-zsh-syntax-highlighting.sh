# ZSH SYNTAX HIGHLIGHTING - install & setup
# Home URL: [zsh-users/zsh-syntax-highlighting: Fish shell like syntax highlighting for Zsh.](https://github.com/zsh-users/zsh-syntax-highlighting)

# Vars
plugName='zsh-syntax-highlighting'
plugInstallerName='zsh-syntax-highlighting.zsh'
plugGitURL='https://github.com/zsh-users/zsh-syntax-highlighting.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-zsh-syntax-highlighting() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_ZSH_SYNTAX_HIGHLIGHTING ; then
    plug-install-zsh-syntax-highlighting
fi

# Uninstall
plug-uninstall-zsh-syntax-highlighting() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_ZSH_SYNTAX_HIGHLIGHTING ; then
    plug-uninstall-zsh-syntax-highlighting
fi

# Source
# zsh-syntax-highlighting.zsh must be sourced at the end of the .zshrc file
if _switchY $PLUG_INSTALL_ZSH_SYNTAX_HIGHLIGHTING && [[ -d $plugCacheDirPath ]]; then
    source "${plugCacheDirPath}/${plugInstallerName}"
fi

# SETUP part ----------------------------------------------------------------------------------
# tip: ls all colors run: zsh-spectrum-ls
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -xA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=007'              # white
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

