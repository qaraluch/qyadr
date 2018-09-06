#!/usr/bin/env bash

################################### UTILS ###################################
# DELIMITER
readonly D_APP='[ QYADR-PURGE ]'

# COLORS
readonly C_R=$'\033[0;31m'            # Red
readonly C_G=$'\033[1;32m'            # Green
readonly C_Y=$'\033[1;33m'            # Yellow
readonly C_B=$'\033[1;34m'            # Blue
readonly C_M=$'\033[1;35m'            # Magenta
readonly C_C=$'\033[1;36m'            # Cyan
readonly C_E=$'\033[0m'               # End

# ICONS
readonly I_T="[ ${C_G}✔${C_E} ]"      # Tick
readonly I_W="[ ${C_Y}!${C_E} ]"      # Warn
readonly I_C="[ ${C_R}✖${C_E} ]"      # Cross
readonly I_A="[ ${C_Y}?${C_E} ]"      # Ask

echoIt() {
  local msg=$1 ; local icon=${2:-''} ; echo "$D_APP$icon $msg" 
}

errorExit() {
  echo "$D_APP$I_C $1" 1>&2 ; exit 1
}

errorExitMainScript() {
  errorExit "${C_R}Sth. went wrong. Aborting script! $C_E"
}

yesConfirm() {
  local ABORT_MSG_DEFAULT="Abort script!"
  local ABORT_MSG=${2:-$ABORT_MSG_DEFAULT}
  read -p "$D_APP$I_A $1" -n 1 -r
  echo >&2
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      errorExit "$ABORT_MSG" 
  fi
}

isDir() {
    local dir=$1
    [[ -d $dir ]]
}

isFile() {
    local file=$1
    [[ -f $file ]]
}

################################### FNS ###################################
uninstallPackages() {
  # auto mode of uninstall script
  isFile ~/.qyadr-install.sh && bash ~/.qyadr-install.sh 2
}

purgeRepos() {
  if isDir ${DOTNAME_FULL} ; then
    rm -rf ${DOTNAME_FULL}
  fi
  # if isDir ${DOTNAMESEC_FULL} ; then
  #   rm -rf ${DOTNAMESEC_FULL}
  # fi
}

purgeUtils() {
  if isFile ${DEPLOY_FULL} ; then
    rm -rf ${DEPLOY_FULL}
  fi
  if isFile ${INSTALL_FULL} ; then
    rm -rf ${INSTALL_FULL}
  fi
  if isFile ${PURGE_FULL} ; then
    rm -rf ${PURGE_FULL}
  fi
  if isFile ${UPDATE_FULL} ; then
    rm -rf ${UPDATE_FULL}
  fi
  if isFile ${PLUGS_CACHE_FULL} ; then
    rm -rf ${PLUGS_CACHE_FULL}
  fi
}

################################### VARS ###################################
readonly DOTNAME='.qyadr'
readonly DOTNAME_FULL="${HOME}/${DOTNAME}"

# readonly DOTNAMESEC='.qyadr-secret'
# readonly DOTNAMESEC_FULL="${HOME}/${DOTNAMESEC}"

readonly DEPLOY_FULL="${HOME}/.qyadr-deploy.sh"
readonly PURGE_FULL="${HOME}/.qyadr-purge.sh"
readonly INSTALL_FULL="${HOME}/.qyadr-install.sh"
readonly UPDATE_FULL="${HOME}/.qyadr-update.sh"
readonly PLUGS_CACHE_FULL="${HOME}/.plugs-cache"

################################### MAIN ###################################
main() {
  echoIt "Welcome to: ${C_Y}Qaraluch's Yet Another Dotfiles Repo Purge Script (QYADR-PURGE)${C_E}"
  echoIt "Used variables:"
  echoIt "  - home dir:              ${C_Y}$HOME${C_E}"
  echoIt "  - qyadr repo:            ${C_Y}$DOTNAME_FULL${C_E}"
  echoIt "  - qyadr-secret repo:     ${C_Y}$DOTNAMESEC_FULL${C_E}"
  echoIt "  - qyadr deploy script:   ${C_Y}$DEPLOY_FULL${C_E}"
  echoIt "  - qyadr install script:  ${C_Y}$INSTALL_FULL${C_E}"
  echoIt "  - qyadr purge script:    ${C_Y}$PURGE_FULL${C_E}"
  echoIt "  - qyadr plugs cache dir: ${C_Y}$PLUGS_CACHE_FULL${C_E}"
  echoIt "Check above installation settings." "$I_W"
  yesConfirm "Ready to roll [y/n]? " 

  uninstallPackages || errorExitMainScript
  echoIt "Uninstalled all QYADR packages." "$I_T"

  purgeRepos || errorExitMainScript
  echoIt "Purged QYADR source dirs from home directory." "$I_T"

  purgeUtils || errorExitMainScript
  echoIt "Purged deploy, install and purge scripts too." "$I_T"

  echoIt "DONE!"
}

main # run it!