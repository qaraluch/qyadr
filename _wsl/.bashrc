# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# For WSL X Server (VcXsrv)
export DISPLAY=localhost:0.0

# launch zsh
if [ -t 1 ]; then
  exec zsh --login
fi
