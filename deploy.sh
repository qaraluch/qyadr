#!/usr/bin/env bash

################################### UTILS ###################################
# DELIMITER
readonly D_APP='[ QYADR-DEPLOY ]'

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

echoIt () {
  local msg=$1 ; local icon=${2:-''} ; echo "$D_APP$icon $msg" 
}

errorExit () {
  echo "$D_APP$I_C $1" 1>&2 ; exit 1
}

errorExitMainScript () {
  errorExit "${C_R}Sth. went wrong. Aborting script! $C_E"
}

yesConfirm () {
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
cleanUps () {
  if isDir ${DOTNAME_FULL} ; then
    rm -rf ${DOTNAME_FULL}
  fi
  if isDir ${DOTNAMESEC_FULL} ; then
    rm -rf ${DOTNAMESEC_FULL}
  fi
}

cloneQyadr () {
  isDir  "$HOME/${DOTNAME}" || \
    git clone --depth 1 https://github.com/qaraluch/qyadr.git ${DOTNAME}
}

copyInstallScript () {
  isFile ${INSTALL_FULL} && \
    cp "${INSTALL_FULL}" "${HOME}/.qyadr-install.sh"
}

copyPurgeScript () {
  isFile ${CLEANUP_FULL} && \
    cp "${CLEANUP_FULL}" "${HOME}/.qyadr-purge.sh"
}

################################### VARS ###################################
readonly DOTNAME='.qyadr'
readonly DOTNAME_FULL="${HOME}/${DOTNAME}"

readonly DOTNAMESEC='.qyadr-secret'
readonly DOTNAMESEC_FULL="${HOME}/${DOTNAMESEC}"

readonly CLEANUP_FULL="${DOTNAME_FULL}/purge.sh"
readonly INSTALL_FULL="${DOTNAME_FULL}/install.sh"

################################### MAIN ###################################
main () {
  echoIt "Welcome to: ${C_Y}Qaraluch's Yet Another Dotfiles Repo Deploy Script (QYADR-DEPLOY)${C_E}"
  echoIt "Used variables:"
  echoIt "  - home dir:       ${C_Y}$HOME${C_E}"
  echoIt "Check above installation settings." "$I_W"
  yesConfirm "Ready to roll [y/n]? " 

  cleanUps || errorExitMainScript
  echoIt "Cleaned up old QYADR source dirs from home directory." "$I_T"

  cloneQyadr || errorExitMainScript
  echoIt "Cloned QYADR repo." "$I_T"
  # cloneQyadrSecret || errorExitMainScript
  
  copyInstallScript || errorExitMainScript
  echoIt "Copied install script to home directory for further use." "$I_T"

  copyPurgeScript || errorExitMainScript
  echoIt "Copied purge script to home directory for further use." "$I_T"

  echoIt "DONE!"
}

main # run it!