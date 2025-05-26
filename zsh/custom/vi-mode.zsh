# Change cursor shape in insert vs normal mode
function zle-keymap-select {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;   # steady block
    viins) echo -ne '\e[5 q' ;;   # blinking bar
  esac
}
zle -N zle-keymap-select
