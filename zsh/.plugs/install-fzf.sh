# FZF - install & setup
# Home URL: [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)

# Vars
plugName='fzf'
plugInstallerName='install'
plugUninstallerName='uninstall'
plugGitURL='https://github.com/junegunn/fzf.git'

plugCacheDirPath="${QYADR_PLUGS_ROOT}-cache/${plugName}"
plugCommandDownload=( git clone --depth 1 "${plugGitURL}" "${plugCacheDirPath}" )

# First time installation
plug-install-fzf() {
    if [[ ! -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${plugName}${_Qce}'." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${plugCommandDownload[@]}")
        _echoDone
    fi
}

if _switchY $PLUG_INSTALL_FZF ; then
    plug-install-fzf
fi

# Uninstall
plug-uninstall-fzf() {
    if [[ -d $plugCacheDirPath ]]; then
        _echoIt "$_QDel" "About to uninstall a '${_Qcy}${plugName}${_Qce}'." "$_Qiw"
        bash ${plugCacheDirPath}/${plugUninstallerName}
        rm -rf $plugCacheDirPath
        _echoDone
    fi
}

if _switchN $PLUG_INSTALL_FZF ; then
    plug-uninstall-fzf
fi

# Fzf installer (one time)
if _switchY $PLUG_INSTALL_FZF && [[ ! -f "${plugCacheDirPath}/bin/fzf" ]]; then
  bash ${plugCacheDirPath}/${plugInstallerName} --no-bash --no-zsh --no-fish --no-update-rc
fi

# SETUP part ----------------------------------------------------------------------------------
if [[ ! "$PATH" == */fzf/bin* ]]; then
  export PATH="$PATH:${plugCacheDirPath}/bin"
fi

# Auto-completion
# if interactive shell add completion
[[ $- == *i* ]] && source "${plugCacheDirPath}/shell/completion.zsh" 2> /dev/null

# Key bindings
source "${plugCacheDirPath}/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS='
    --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
    --color info:144,prompt:161,spinner:135,pointer:135,marker:118
'