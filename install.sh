#!/usr/bin/env bash

################################### UTILS ###################################
# DELIMITER
readonly D_APP='[ QYADR ]'

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
  read -p "$D_APP$I_A $1 " -n 1 -r
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
stowErrorMsg () {
  echoIt "Cannot stowed package name: $1 (Is this correct name?)" "$I_C" 
}

stowAll () {
  for PACK in "${PACKS[@]}" ; do
  if isDir "$DOTNAME_FULL/$PACK" ; then
    stow -vd ${DOTNAME_FULL} -S ${PACK} -t ${HOME} 
    echoIt "Stowed package name: ${PACK}" "$I_T" 
  else 
    stowErrorMsg ${PACK}
    return 1
  fi
  done
}

unstowAll () {
  for PACK in "${PACKS[@]}" ; do
  if isDir "$DOTNAME_FULL/$PACK" ; then
    stow -vd ${DOTNAME_FULL} -D ${PACK} -t ${HOME} 
    echoIt "Unstowed package name: ${PACK}" "$I_T" 
  else 
    stowErrorMsg ${PACK}
    return 1
  fi
  done
}

showPackages () {
  echoIt "List of packages:"
  for PACK in "${PACKS[@]}" ; do
    echoIt " - ${PACK}"  
  done
}


################################### VARS ###################################
readonly DOTNAME='.qyadr'
readonly DOTNAME_FULL="${HOME}/${DOTNAME}"

readonly DOTNAMESEC='.qyadr-secret'
readonly DOTNAMESEC_FULL="${HOME}/${DOTNAMESEC}"

declare -a PACKS=( \
  zsh \
)

################################### MAIN ###################################
declare -a MENU_OPTIONS=( \
  "   [ 1 ] Install all configs" \
  "   [ 2 ] Delete all the configs installed" \
  "   [ 3 ] View all QYADR's packages" \
  "   [ 4 ] Quit" \
)

showMenuOptions () {
  echoIt "  [ Choose one of the options bellow: ] ---------------" "${I_A}"
  for OPTION in "${MENU_OPTIONS[@]}" ; do
    echoIt "${OPTION}"
  done
}

readMenuOptionInput () {
  read  -p "                 [ Enter your choice: ${C_B}>${C_E} " -n 1 -r
  echo >&2
  echo ${REPLY}
}

execMenuOption () {
  local CHOSEN=$1
  local CHOSEN_MENU_OPTION_TXT=${MENU_OPTIONS[${CHOSEN}-1]}
  if [[ "$CHOSEN" == 1 ]] ; then
    yesConfirm "Ready to: ${C_Y}$CHOSEN_MENU_OPTION_TXT${C_E} [y/n]?" \
      && stowAll || errorExitMainScript
    echoIt "Installed all dofiles in home directory."
    echoDone
  elif [[ "$CHOSEN" == 2 ]] ; then
    yesConfirm "Ready to: ${C_Y}$CHOSEN_MENU_OPTION_TXT${C_E} [y/n]?" \
      && unstowAll || errorExitMainScript
    echoIt "Uninstalled all dofiles in home directory."
    echoDone
  elif [[ "$CHOSEN" == 3 ]] ; then
      showPackages || errorExitMainScript
      launchMenu
  else
    echoIt "Quitting script!"
    exit 0
  fi
}

launchMenu () {
  showMenuOptions
  local CHOSENOPTION=$(readMenuOptionInput)
  execMenuOption $CHOSENOPTION
}

main () {
  echoIt "Welcome to: ${C_Y}Qaraluch's Yet Another Dotfiles Repo script (QYADR)${C_E}"
  echoIt "Used variables:"
  echoIt "  - home dir:           ${C_Y}$HOME${C_E}"
  echoIt "  - qyadr repo:         ${C_Y}$DOTNAME_FULL${C_E}"
  echoIt "  - qyadr secret repo:  ${C_Y}$DOTNAMESEC_FULL${C_E}"
  echoIt "Check above installation settings." "$I_W"
  launchMenu
}

main # run it!