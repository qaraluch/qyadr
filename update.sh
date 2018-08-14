#!/usr/bin/env bash

################################### UTILS ###################################
# DELIMITER
readonly D_APP='[ QYADR-UPDATE ]'

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

echoDone () {
  echoIt "DONE!" "$I_T"
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
updateRepos () {
  if isDir ${DOTNAME_FULL} ; then
    cd ${DOTNAME_FULL}
    execGitPull || errorExitMainScript
    echoIt "Updated: ${DOTNAME}" "${I_T}"
  fi
  if isDir ${DOTNAMESEC_FULL} ; then
    cd ${DOTNAMESEC_FULL}
    execGitPull || errorExitMainScript
    echoIt "Updated: ${DOTNAMESEC}" "${I_T}"
  fi
}

execGitPull () {
  git pull --rebase --stat origin master
}

################################### VARS ###################################
readonly DOTNAME='.qyadr'
readonly DOTNAME_FULL="${HOME}/${DOTNAME}"

readonly DOTNAMESEC='.qyadr-secret'
readonly DOTNAMESEC_FULL="${HOME}/${DOTNAMESEC}"

################################### MAIN ###################################
main () {
  echoIt "Welcome to: ${C_Y}Qaraluch's Yet Another Dotfiles Repo ${C_G}UPDATE${C_E} Script (QYADR-UPDATE)${C_E}"
  yesConfirm "Ready to roll [y/n]? " 
  updateRepos 
  echoIt "${C_G}QYADR is up-to-date!${C_E}" "$I_T"
  echoDone
}

main # run it!