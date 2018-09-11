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
    kubectl
    helm
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

## encrypted external devices
export DUCK_EXTERNAL=$(cat ~/.keys/duck_external_pw)
alias open_duck_external="echo -n $DUCK_EXTERNAL | sudo cryptsetup luksOpen --key-file=/home/fradeve/.keys/duck_external_keyfile /dev/sda duck-external"
alias mount_duck_external="sudo mount -t ext4 /dev/mapper/duck-external ~/external"

## nodejs
PATH=$PATH:~/.node_modules/bin

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## gcloud
source '/opt/google-cloud-sdk/path.zsh.inc'
source '/opt/google-cloud-sdk/completion.zsh.inc'

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

## perl
PATH="~/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="~/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="~/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/fradeve/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fradeve/perl5"; export PERL_MM_OPT;

## postgres
export PGDATA=/home/postgres/data

## kubernetes
alias kube-weave="kubectl port-forward -n weave \"$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')\" 4040"

autoload -U compinit compdef
compinit
