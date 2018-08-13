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

pressAnyKey () {
  read -n 1 -s -r -p "$D_APP Press [any] key to continue."
  echo >&2
}

isEqualY () {
  local STRING=$1
  [[ "$STRING" == "Y" ]]
}

isEqualN () {
  local STRING=$1
  [[ "$STRING" == "N" ]]
}

switchYN () {
  local SWITCH=$1
  if isEqualY $SWITCH; then
    return 0
  else
    return 1
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
  isDir ${DOTNAME_FULL} && rm -fm ${DOTNAME_FULL}
  isDir ${DOTNAMESEC_FULL} && rm -fm ${DOTNAMESEC_FULL}
  echoIt "Cleaned up QYADR source dirs from home directory." "$I_T"
}

cloneQyadr () {
  isDir  "$HOME/${DOTNAME}" || \
    git clone --depth 1 https://github.com/qaraluch/qyadr.git ${DOTNAME}
  echoIt "Cloned QYADR repo." "$I_T"
}

copyPurgeScript () {
  isFile ${CLEANUP_FULL} && \
    cp "${DOTNAME_FULL}/purge.sh" "${HOME}/.qyadr-purge.sh"
  echoIt "Copied purge script to home directory." "$I_T"
}

################################### VARS ###################################
readonly DOTNAME='.qyadr'
readonly DOTNAME_FULL="${HOME}/${DOTNAME}"

readonly DOTNAMESEC='.qyadr-secret'
readonly DOTNAMESEC_FULL="${HOME}/${DOTNAMESEC}"

readonly CLEANUP_FULL="${DOTNAME_FULL}/cleanup.sh"

################################### MAIN ###################################
main () {
  echoIt "Welcome to: ${C_Y}Qaraluch's Yet Another Dotfiles Repo Deploy Script (QYADR-DEPLOY)${C_E}"
  echoIt "Used variables:"
  echoIt "  - home dir:       ${C_Y}$HOME${C_E}"
  echoIt "Check above installation settings." "$I_W"
  yesConfirm "Ready to roll [y/n]? " 

  # Cleans up repo dirs e.i.: qyadr and qyadr-secret
  cleanUps || errorExitMainScript

  cloneQyadr || errorExitMainScript
  # cloneQyadrSecret || errorExitMainScript
  
  # Copy to homedir script that purge all qyadr files.
  copyPurgeScript || errorExitMainScript

  echoIt "DONE!"
}

main # run it!