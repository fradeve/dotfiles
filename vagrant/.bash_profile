# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias ll='ls -l'
fi

# autostart tmux on ssh connection
if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
        STARTED_TMUX=1; export STARTED_TMUX
        sleep 1
        ( (tmux has-session -t remote && tmux attach-session -t remote) || (tmux new-session -s remote) ) && exit 0
        echo "tmux failed to start"
fi

## tmuxifier
export TMUXIFIER="$HOME/.bin/tmuxifier"                         # main executable / git repo
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier"                 # layouts rc dir
[[ -s "$TMUXIFIER/init.sh" ]] && source "$TMUXIFIER/init.sh"    # init file


PS1="\n\$(if [[ \$? == 0 ]]; then echo \"\[\033[0;34m\]\"; else echo \"\[\033[0;31m\]\"; fi)\342\226\210\342\226\210 [ \W ] [ \t ]\n\[\033[0m\]\342\226\210\342\226\210 "
