# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=10

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

### plugins options ####
########################

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
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
        )

source $ZSH/oh-my-zsh.sh

## history-substring-search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### misc settings ########
##########################

export PATH=$HOME/.bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
export EDITOR='vim'

# stop rm confirmation request
setopt RmStarSilent

### alias ####
##############

## music
MONTH_NOW=`date +'%m'`
MONTH_START=`date --date='-6 month' +'%m'`
YEAR_NOW=`date +'%Y'`
alias beet_latest='beet ls -a "added:$YEAR_NOW-$MONTH_NOW..$YEAR_NOW-$MONTH_START"'
alias music='ncmpcpp'
alias music-on='ncmpcpp -h moon.ydns.eu -p 6600'

alias dff='pydf | grep -v "Private" | grep -v "efi" | grep -v "home/fradeve/DATA" | grep -v ".backup"'

## networking / ssh
alias pong='ping www.google.it' 
alias backup-edgar='rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_edgar.include --exclude / / fradeve@moon::/unenc/fradeve/btsync/dev/edgar'

## latex / vim
alias sutlmgr='sudo /usr/local/texlive/2013/bin/x86_64-linux/tlmgr'
alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

## alias mutt / IM
alias mutt='mutt -n -F /home/fradeve/.mutt/muttrc'
alias mutton='mutt -n -F /home/fradeve/.mutt/muttonrc'
alias trans='transmission-remote-cli -f ~/.trclirc'
alias oblique='sh /opt/oblique'

## alias tmux
alias mux='tmuxp load .tmuxp/base.yaml'

## alias timebook
unalias t

### ENV and apps settings ###
#############################

## crontab editor
export VISUAL=vim

## TexLive executables
export PATH=/usr/local/texlive/2013/bin/x86_64-linux:${PATH}

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## tmuxp autocompletion
source tmuxp.zsh

## fabric
export PYTHONDONTWRITEBYTECODE=True  # in python2 avoid creation of .pyc

## python virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=~/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
source /usr/bin/virtualenvwrapper.sh

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
export EDITOR=vim

## powerline
. /usr/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh

## chromium cache in tmp
export CHROMIUM_USER_FLAGS="--disk-cache-dir=/tmp --disk-cache-size=50000000"

## ncl
export NCARG_ROOT='/usr/lib/ncarg'

## dircolors
eval $(dircolors -b $HOME/.ansi-dark)
## PyCharm font not showing error
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

## overwrites oh-my-zsh's completion ssh completion plugin with configs from .ssh/config
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
zstyle ':completion:*:hosts' hosts $_ssh_config
