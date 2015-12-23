### main oh-my-zsh options ###
##############################

. $HOME/.zshrc_base

### plugins options ####
########################

plugins=(
         git
         archlinux
         extract
         common-aliases
         vi-mode
         history-substring-search
         colored-man
         colorize
         cp
         completion
         docker
        )

. $HOME/.zshrc_plugins

### misc settings ###
#####################

. $HOME/.zshrc_misc

### alias ###
#############

. $HOME/.zshrc_alias

alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"
alias oblique='sh /opt/oblique'
alias mux='tmuxp load .tmuxp/base.yaml'
alias backup-edgar='rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_edgar.include --exclude / / fradeve@moon::/unenc/fradeve/btsync/dev/edgar'

## music
MONTH_NOW=`date +'%m'`
MONTH_START=`date --date='-2 month' +'%m'`
YEAR_NOW=`date +'%Y'`
alias beet_latest='beet ls -a "added:$YEAR_NOW-$MONTH_START..$YEAR_NOW-$MONTH_NOW"'
alias music='ncmpcpp'
alias music-on='ncmpcpp -h moon-fradeve.duckdns.org -p 6600'

## git
alias gpf="git fetch -p"

gdf() { 
    if [[ ! $1 ]]; then
        local branch="master"
    fi
    cdiff -s -w90 $branch; 
}

### env and apps settings ###
#############################

. $HOME/.zshrc_env_apps

## tmuxp autocompletion
source tmuxp.zsh

## python pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=/home/fradeve/git/pass-android

## chromium cache in tmp
export CHROMIUM_USER_FLAGS="--disk-cache-dir=/tmp --disk-cache-size=50000000"

## ncl
export NCARG_ROOT='/usr/lib/ncarg'
export PATH=$NCARG_ROOT/bin:$PATH

## PyCharm font not showing error
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add
