# Locate database
# creation, update and remove scripts
# tailored for arch

locate-update-dbs() {
  _echoIt "$_QDel" "About to ${_cy}update${_ce} locate database..."
  sudo updatedb
  _echoDone
}

locate-get-data() {
  echo "$(locate /)"
}

locate-remove-dbs() {
  _echoIt "$_QDel" "About to ${_cy}remove${_ce} locate database..."
  sudo rm /var/lib/mlocate/mlocate.db
  _echoDone
}