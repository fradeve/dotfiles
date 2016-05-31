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
        )

. $HOME/.zshrc_plugins

### misc settings ###
#####################

. $HOME/.zshrc_misc

### alias ###
#############

. $HOME/.zshrc_alias

alias last-zerzan='find /unenc/fradeve/sync/dev/zerzan -printf "%T+\n" | sort -nr | head -n 1'
alias last-emmett='find /unenc/fradeve/sync/dev/emmett -printf "%T+\n" | sort -nr | head -n 1'

### env and apps settings ###
#############################

. $HOME/.zshrc_env_apps
