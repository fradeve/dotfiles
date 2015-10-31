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

. $HOME/.zshrc_alias

alias sutlmgr='sudo /usr/local/texlive/2014/bin/x86_64-linux/tlmgr'
alias makelatex="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"

alias backup-duck="rdiff-backup -v5 --include-globbing-filelist /home/fradeve/.bin/back_duck.include --exclude / / fradeve@moon::/unenc/fradeve/btsync/dev/duck"

## git
eval "$(hub alias -s)"

alias git="hub"
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

## TexLive executables
export PATH=/usr/local/texlive/2014/bin/x86_64-linux:${PATH}

## tmuxp autocompletion
#source tmuxp.zsh

## ruby
export PATH=/home/fradeve/.gem/ruby/2.1.0/bin:${PATH}
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

## node
PATH=$PATH:~/.node_modules/bin

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

## ncl
export NCARG_ROOT=/usr/lib/ncarg
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

## perl
PATH="/home/fradeve/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/fradeve/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/fradeve/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/fradeve/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fradeve/perl5"; export PERL_MM_OPT;
