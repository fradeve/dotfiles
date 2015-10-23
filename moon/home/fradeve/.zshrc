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
         taskwarrior
        )

. $HOME/.zshrc_plugins

### misc settings ###
#####################

. $HOME/.zshrc_misc

### alias ###
#############

. $HOME/.zshrc_alias

alias t='task X project:work status:pending'              # lists project:work tasks
alias ta='task next project.not:work tag.not:longterm status:pending'      # list non-work tasks
alias ts='task sync'                                      # sync with Task Server
alias td='task due:today'                                 # tasks to be done today
alias tbd='task burndown.daily project:work'              # list burntdown tasks from work

alias last-moon='find /unenc/fradeve/btsync/dev/moon -printf "%T+\n" | sort -nr | head -n 1'
alias last-emmett='find /unenc/fradeve/btsync/dev/emmett -printf "%T+\n" | sort -nr | head -n 1'

alias btsync-start='systemctl --user start btsync'
alias btsync-stop='systemctl --user stop btsync'

### env and apps settings ###
#############################

. $HOME/.zshrc_env_apps

## ruby
export PATH=/home/fradeve/.gem/ruby/2.1.0/bin:${PATH}
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')

## node
PATH=$PATH:~/.node_modules/bin
