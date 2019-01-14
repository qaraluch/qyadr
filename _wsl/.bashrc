# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# launch zsh
if [ -t 1 ]; then
  exec zsh --login
fi
