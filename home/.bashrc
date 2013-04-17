# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_profile

## crontab: export editor to run when invoking crontab
export VISUAL=vim

## tmuxinator Arch
export EDITOR='vim'
[[ -s $HOME/.tmuxinator/scripts ]] && source $HOME/.tmuxinator/scripts
