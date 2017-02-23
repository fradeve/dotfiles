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

. $HOME/.zshrc_generic_alias
. $HOME/.zshrc_music
. $HOME/.zshrc_tex

alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"
alias oblique='sh /opt/oblique'
alias mux='tmuxp load .tmuxp/base-on.yaml'
alias backup-edgar='rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_edgar.include --exclude / / fradeve@zerzan::/unenc/fradeve/sync/dev/edgar'

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

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=/home/fradeve/git/pass

## chromium cache in tmp
export CHROMIUM_USER_FLAGS="--disk-cache-dir=/tmp --disk-cache-size=50000000"

## PyCharm font not showing error
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add
