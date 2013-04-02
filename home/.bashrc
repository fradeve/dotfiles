# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_profile

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias ll='ls -l'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
    alias dff='pydf | grep -v "Private" | grep -v "efi" | grep -v "home/fradeve/DATA" | grep -v ".backup" | grep -v ".irssi"'

## networking / ssh
    alias pong='ping www.google.it' 

## latex / vim
    alias sutlmgr='sudo /usr/local/texlive/2012/bin/x86_64-linux/tlmgr'
    alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

## alias mutt / IM
    alias mutt='mutt -n -F /home/fradeve/.mutt/muttrc'
    alias mutton='mutt -n -F /home/fradeve/.mutt/muttonrc'
    alias irssi='screen irssi'
    alias dati='gpg -d $HOME/DATA/Dropbox/documenti/dati.csv.gpg | grep '
    alias oblique='sh /opt/oblique'
    alias music='sh /home/fradeve/.bin/music'

## gtd
    alias t='cat /home/fradeve/DATA/Dropbox/apps/todo/remember && todo.sh -d /home/fradeve/.todo.cfg'
    export TODOTXT_DEFAULT_ACTION=ls
fi

## crontab: export editor to run when invoking crontab
export VISUAL=vim

## tmuxinator Arch
export EDITOR='vim'
[[ -s $HOME/.tmuxinator/scripts ]] && source $HOME/.tmuxinator/scripts
