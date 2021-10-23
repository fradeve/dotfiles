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

. $HOME/.zshrc_env_apps

## pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## gcloud

# update PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# enable shell command completion for gcloud.
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

## put ssh-agent variables in session
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

## nodejs
PATH=$PATH:~/.node_modules/bin

## ruby
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

autoload -U compinit compdef
compinit
