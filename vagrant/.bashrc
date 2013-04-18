[[ $- != *i* ]] && return
[[ $TERM != "screen" ]] && exec tmux

source $HOME/.bash_profile
