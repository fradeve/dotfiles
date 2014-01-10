#
# ~/.bash_profile
#

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
    alias btsync-start='sudo systemctl start btsync@fradeve.service'
    alias btsync-stop='sudo systemctl stop btsync@fradeve.service'

## latex / vim
    alias sutlmgr='sudo /usr/local/texlive/2013/bin/x86_64-linux/tlmgr'
    alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

## alias mutt / IM
    alias mutt='mutt -n -F /home/fradeve/.mutt/muttrc'
    alias mutton='mutt -n -F /home/fradeve/.mutt/muttonrc'
    alias irssi='screen irssi'
    alias trans='transmission-remote-cli -f ~/.trclirc'
    alias oblique='sh /opt/oblique'

## alias tmux
    alias mux='teamocil base'

## gtd
    alias t='cat /home/fradeve/DATA/Dropbox/apps/todo/remember && todo.sh -d /home/fradeve/.todo.cfg'
    export TODOTXT_DEFAULT_ACTION=ls
fi

## crontab editor
export VISUAL=vim

## TexLive executables
export PATH=/usr/local/texlive/2013/bin/x86_64-linux:${PATH}

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## ruby
export PATH=/home/fradeve/.gem/ruby/2.0.0/bin:${PATH}

## fabric
export PYTHONDONTWRITEBYTECODE=True  # in python2 avoid creation of .pyc

## python virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=~/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
source /usr/bin/virtualenvwrapper.sh

## pass
source /etc/bash_completion.d/password-store
export PASSWORD_STORE_DIR=/home/fradeve/DATA/Dropbox/apps/pass
export EDITOR=vim

## powerline
. /usr/lib/python3.3/site-packages/powerline/bindings/bash/powerline.sh

## teamocil
complete -W "$(teamocil --list)" teamocil

PS1='[\u@\h \W]\$ '
