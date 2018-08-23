# Utilities for QYADR functions

# qyadr delimiter
readonly D_Q='[ QYADR ]'

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

emptyLine() { echo "" >&2 }

echoIt () {
  local MSG=$1 ; local ICON=${2:-''} ; echo "${D_Q}${ICON} $MSG" >&2
}

echoDone () {
  echoIt "DONE!" "$I_T"
}

# TIMESTAMPS
getTimeStamp () {
  echo $(date +%s)
}

getTimeStampHuman () { 
  echo $(date -d @"$(getTimeStamp)" +'%Y-%m-%d %H:%M:%S')
}

getTimeStampHumanFile () { 
  echo $(date -d @"$(getTimeStamp)" +'%Y-%m-%d_%H%M%S')
}

# SWITCHES
isEqualY () {
  local STRING=$1
  [[ "$STRING" == "Y" ]]
}

isEqualN () {
  local STRING=$1
  [[ "$STRING" == "N" ]]
}

switchY () {
  local SWITCH=$1
  if isEqualY $SWITCH; then
    return 0
  else
    return 1
  fi
}

switchN () {
  local SWITCH=$1
  if isEqualN $SWITCH; then
    return 0
  else
    return 1
  fi
}

# PROFILING
profileFor() {
  if switchY $ZSH_PROFILE ; then
    PROFILE_MSG=${1:-Run profile for sth...}
    _timer=$(($(date +%s%N)/1000000)) 
  fi
}

profileStop() {
  if switchY $ZSH_PROFILE ; then
    _now=$(($(date +%s%N)/1000000))
    echo "[!] ---> elapsed: $(($_now-$_timer)) ms for: ${PROFILE_MSG}"
  fi
}
