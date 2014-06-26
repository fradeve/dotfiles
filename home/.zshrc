# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

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
        )

source $ZSH/oh-my-zsh.sh

## history-substring-search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

### misc settings ########
##########################

export PATH=$HOME/.bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# stop rm confirmation request
setopt RmStarSilent

### alias ####
##############

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
alias mux='teamocil --here base'

## alias time tracking
alias ttt='timetrap'                                        # start activity now
alias ttta='timetrap i -a '                                 # start past activity at time...
alias tttc='timetrap o -a '                                 # stop past activity at time...
alias ttto='clear && timetrap d all --ids -s 'today' -f by_day'     # list all today activities
alias ttye='clear && timetrap d all --ids -s 'yesterday' -f by_day' # list all yesterday activities
alias ttwe='clear && timetrap week --ids all'                       # list all activities this week
alias tttd='timetrap d --start "00.00am" --end "11.59pm" -f day'    # percentage working hours today

## gtd
alias t='cat /home/fradeve/DATA/Dropbox/apps/todo/remember && todo.sh -d /home/fradeve/.todo.cfg list'

### ENV and apps settings ###
#############################

## crontab editor
export VISUAL=vim

## TexLive executables
export PATH=/usr/local/texlive/2013/bin/x86_64-linux:${PATH}

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## ruby
export PATH=/home/fradeve/.gem/ruby/2.1.0/bin:${PATH}
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

## fabric
export PYTHONDONTWRITEBYTECODE=True  # in python2 avoid creation of .pyc

## python virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=~/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
source /usr/bin/virtualenvwrapper.sh

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=/home/fradeve/DATA/Dropbox/apps/pass
export EDITOR=vim

## powerline
. /usr/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh

## teamocil
compctl -g '~/.teamocil/*(:t:r)' teamocil

## timetrap
fpath=(. /home/fradeve/.gem/ruby/2.0.0/gems/timetrap-1.8.12/completions/zsh $fpath)

## dircolors
eval $(dircolors -b $HOME/.ansi-dark)
