#!/bin/sh
ssh -t emmett 'clear && task +polestar agile.not:devcomplete next; zsh'
read -p "Press Enter to close the window."
