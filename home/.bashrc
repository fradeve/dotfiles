# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_profile


## [tmux] automagically exec tmux when starting new terminal
############################################################

[[ $TERM != "screen" ]] && exec tmux
