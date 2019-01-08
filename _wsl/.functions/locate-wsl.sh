# Locate database
# creation, update and remove scripts
# tailored for WSL

export QYADR_LOCATE_DIR="${HOME}/.locate-dbs"

locate-update-dbs() {
  _echoIt "$_QDel" "About to ${_cy}update${_ce} locate database..."
  if _isNotDir $QYADR_LOCATE_DIR ; then
    mkdir $QYADR_LOCATE_DIR
    [[ $? ]] && _echoIt "$_QDel" "Created locate database directory: ${_cy}${QYADR_LOCATE_DIR}${_ye}"
  fi
  _locate-update-db-home
}

_locate-update-db-home() {
  local sourcePath="${HOME}"
  local sourceName='home'
  if _isDir ${HOME} ; then
    command updatedb -l 0 -U "${sourcePath}/" -o "${QYADR_LOCATE_DIR}/${sourceName}.db"
    _echoIt "${_QDel}" "  ... updated: ${_cy}${sourceName}${_ce}${_ce}.db" "${_it}"
    echo
  else
    _echoIt "${_QDel}" "[ ${_cy}!${_ce} ] Not found dir: ${sourcePath}" "${_iw}"
  fi
}

locate-get-data() {
  echo "$(locate -d "${QYADR_LOCATE_DIR}/home.db" /)"
}

locate-remove-dbs() {
  _echoIt "$_QDel" "About to ${_cy}remove${_ce} locate database..."
  rm -rf $QYADR_LOCATE_DIR
  _echoDone
}