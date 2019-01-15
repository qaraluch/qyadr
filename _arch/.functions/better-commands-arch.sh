# Open in browser from cli
browser-open() {
  local url="${1:-'https://duckduckgo.com'}"
  "$BROWSER" --new-window "${url}" >/dev/null 2>&1 &
}
