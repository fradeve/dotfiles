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
    colored-man-pages
    colorize
    cp
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

### env and apps settings ###
#############################

## crontab editor
export VISUAL=vim

## fradeve's local bins
export PATH=/home/fradeve/.bin:${PATH}

## overwrites oh-my-zsh's SSH completion plugin with configs from .ssh/config
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
zstyle ':completion:*:hosts' hosts $_ssh_config

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

## dircolors
eval $(dircolors -b $HOME/.ansi-dark)

## pyenv
eval "$(pyenv init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## gcloud

# update PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# enable shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

## kubectl / helm
source <(kubectl completion zsh)
source <(helm completion zsh)
export PATH="${PATH}:${HOME}/.krew/bin"

export KUBE_EDITOR=vim
export HELM_BURST_LIMIT=300

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=~/git/pass

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

## nodejs
PATH=$PATH:~/.node_modules/bin

autoload -Uz compinit compdef
compinit
