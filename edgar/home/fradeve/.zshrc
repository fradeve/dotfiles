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
        )

. $HOME/.zshrc_plugins

### misc settings ###
#####################

. $HOME/.zshrc_misc

### alias ###
#############

. $HOME/.zsh_alias

alias sutlmgr='sudo /usr/local/texlive/2013/bin/x86_64-linux/tlmgr'
alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

alias oblique='sh /opt/oblique'

alias mux='tmuxp load .tmuxp/base.yaml'

alias backup-edgar='rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_edgar.include --exclude / / fradeve@moon::/unenc/fradeve/btsync/dev/edgar'

## music
MONTH_NOW=`date +'%m'`
MONTH_START=`date --date='-6 month' +'%m'`
YEAR_NOW=`date +'%Y'`
alias beet_latest='beet ls -a "added:$YEAR_NOW-$MONTH_START..$YEAR_NOW-$MONTH_NOW"'
alias music='ncmpcpp'
alias music-on='ncmpcpp -h moon-fradeve.duckdns.org -p 6600'

## git
eval "$(hub alias -s)"

alias git="hub"
alias gpf="git fetch -p"
alias gdf="cdiff -s -w90"

### env and apps settings ###
#############################

. $HOME/.zshrc_env_apps

## TexLive executables
export PATH=/usr/local/texlive/2013/bin/x86_64-linux:${PATH}

## tmuxp autocompletion
source tmuxp.zsh

## python pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
    versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
    if [ "${#versions[@]}" -eq 1 ]; then
        PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
    fi
fi

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
