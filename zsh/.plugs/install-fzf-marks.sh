# FZF-MARKS - install & setup
# Home URL: [urbainvaes/fzf-marks: Plugin to manage bookmarks in bash and zsh](https://github.com/urbainvaes/fzf-marks)

# Vars
plugName='fzf-marks'
plugInstallerName='fzf-marks.plugin.zsh'
plugGitURL='https://github.com/urbainvaes/fzf-marks.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-fzf-marks() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_FZF_MARKS; then
    plug-install-fzf-marks
fi

# Uninstall
plug-uninstall-fzf-marks() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}' plugin." "$_Qiw"
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_FZF_MARKS; then
    plug-uninstall-fzf-marks
fi

# Source
if _switchY $PLUG_INSTALL_FZF_MARKS&& [[ -d $plugCacheDirPath ]]; then
    source "${plugCacheDirPath}/${plugInstallerName}"
fi

# SETUP part ----------------------------------------------------------------------------------
# n/n