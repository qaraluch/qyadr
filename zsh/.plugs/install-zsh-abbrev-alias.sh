# ZSH-ABBREV-ALIAS - install & setup
# Home URL: [momo-lab/zsh-abbrev-alias: This zsh plugin provides functionality similar to Vim's abbreviation expansion.](https://github.com/momo-lab/zsh-abbrev-alias)

# Vars
plugName='zsh-abbrev-alias'
plugInstallerName='abbrev-alias.plugin.zsh'
plugGitURL='https://github.com/momo-lab/zsh-abbrev-alias.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-zsh-abbrev-alias() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_ZSH_ABBREV_ALIAS ; then
    plug-install-zsh-abbrev-alias
fi

# Uninstall
plug-uninstall-zsh-abbrev-alias() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_ZSH_ABBREV_ALIAS ; then
    plug-uninstall-zsh-abbrev-alias
fi

# Source
if _switchY $PLUG_INSTALL_ZSH_VIMTO && [[ -d $plugCacheDirPath ]]; then
    source "${plugCacheDirPath}/${plugInstallerName}"
fi

# SETUP part ----------------------------------------------------------------------------------
# n/n