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

alias backup-duck="rdiff-backup -v5 --include-globbing-filelist ~/.back_duck.include --exclude / / fradeve@zerzan::/unenc/fradeve/sync/dev/duck"

### env and apps settings ###
#############################

. $HOME/.zshrc_env_apps

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## gcloud

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

## kubectl / helm
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

## pass
fpath=(. /usr/share/zsh/site-functions/_pass $fpath)
export PASSWORD_STORE_DIR=~/git/pass

## PyCharm font not showing error
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

## nodejs
PATH=$PATH:~/.node_modules/bin

## postgres
export PGDATA=/home/postgres/data

autoload -U compinit compdef
compinit
