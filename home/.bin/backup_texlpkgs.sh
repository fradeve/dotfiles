#!/bin/bash
#NOW=$(date +"%d-%b-%y-%k.%M")
TEXLOGFILE="texlive_pkgs.log"
rm $HOME/.bin/texlive_pkgs.log
tlmgr list --only-installed | awk -F: '{print $1}' | sed 's/^..//g' > $HOME/.bin/$TEXLOGFILE
