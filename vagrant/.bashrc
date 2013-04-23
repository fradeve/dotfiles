[[ $- != *i* ]] && return

source $HOME/.bash_profile

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
