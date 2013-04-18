# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# automagically exec tmux when starting new terminal
[[ $TERM != "screen" ]] && exec tmux

source $HOME/.bash_profile

## crontab: export editor to run when invoking crontab
export VISUAL=vim
