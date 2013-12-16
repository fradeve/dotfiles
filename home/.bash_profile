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

## latex / vim
    alias sutlmgr='sudo /usr/local/texlive/2013/bin/x86_64-linux/tlmgr'
    alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

## alias mutt / IM
    alias mutt='mutt -n -F /home/fradeve/.mutt/muttrc'
    alias mutton='mutt -n -F /home/fradeve/.mutt/muttonrc'
    alias irssi='screen irssi'
    alias oblique='sh /opt/oblique'

## alias tmux
    alias mux='tmuxifier load-session base'

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

## tmuxifier
export TMUXIFIER="$HOME/.bin/tmuxifier"                         # main executable / git repo
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier"                 # layouts rc dir
[[ -s "$TMUXIFIER/init.sh" ]] && source "$TMUXIFIER/init.sh"    # init file

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

### CODE FOR $PS1 ###
#####################

# Colour Codes
export Cyan="\[\e[m\]\[\e[0;36m\]"
export Red="\[\e[m\]\[\e[0;31m\]"
export White="\[\e[m\]\[\e[1;37m\]"
export LightCyan="\[\e[m\]\[\e[1;36m\]"
export LightRed="\[\e[m\]\[\e[1;31m\]"

# Code for a cool Prompt
function pre_prompt
{
    newPWD="${PWD}"
    user="whoami"
    host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
    datenow=$(date "+%a, %d %b %y")
    let promptsize=$(echo -n "--($user@$host ddd, DD mmm YY)---(${PWD})---" \
                 | wc -c | tr -d " ")

    width=$(tput cols)

    if [ `id -u` -eq 0 ]
    then
        let fillsize=${width}-${promptsize}+1
    else
        let fillsize=${width}-${promptsize}-1
    fi

    fill=""

    while [ "$fillsize" -gt "0" ]
    do
        fill="${fill}─"
        let fillsize=${fillsize}-1
    done

    if [ "$fillsize" -lt "0" ]
    then
        let cutt=3-${fillsize}
        newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
    fi
}

# Set prompt colour
if [ `id -u` -eq 0 ]
then
    cText="${LightRed}"
    cBorder="${Red}"
else
    cText="${LightCyan}"
    cBorder="${Cyan}"
fi

PROMPT_COMMAND=pre_prompt

# Display Prompt
PS1="${cBorder}┌─(${White}\u@\h \$(date \"+%a, %d %b %y\")${cBorder})─\${fill}─(${cText}\$newPWD\
${cBorder})────┐\n${cBorder}└─(${cText}\$(date \"+%H:%M\")${cBorder})─> ${White}"

#PS1='[\u@\h \W]\$ '
