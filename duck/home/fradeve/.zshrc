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
export UPDATE_ZSH_DAYS=10

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
         completion
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
export EDITOR=vim

# stop rm confirmation request
setopt RmStarSilent

### alias ####
##############

## networking / ssh
alias pong='ping www.google.it' 

## latex / vim
alias sutlmgr='sudo /usr/local/texlive/2014/bin/x86_64-linux/tlmgr'
alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

## mutt / IM
alias mutt='mutt -n -F /home/fradeve/.mutt/muttrc'
alias mutton='mutt -n -F /home/fradeve/.mutt/muttonrc'

## backup
alias backup-duck="rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_duck.include --exclude / / fradeve@moon::/unenc/fradeve/btsync/dev/duck"

## git
eval "$(hub alias -s)"

alias git="hub"
alias gpf="git fetch -p"
gdf() { cdiff -s -w90 "$*"; }

### ENV and apps settings ###
#############################

## crontab editor
export VISUAL=vim

## TexLive executables
export PATH=/usr/local/texlive/2014/bin/x86_64-linux:${PATH}

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## tmuxp autocompletion
#source tmuxp.zsh

## ruby
export PATH=/home/fradeve/.gem/ruby/2.1.0/bin:${PATH}
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

## node
PATH=$PATH:~/.node_modules/bin

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

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=/home/fradeve/git/pass-android

## powerline
. /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh

## ncl
export NCARG_ROOT=/usr/lib/ncarg
export PATH=$NCARG_ROOT/bin:$PATH

## dircolors
eval $(dircolors -b $HOME/.ansi-dark)

## PyCharm font not showing error
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

## Keypad
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
