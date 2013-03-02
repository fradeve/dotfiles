#!/bin/sh
gpg --quiet --batch --no-tty --no-use-agent --passphrase-file $HOME/.offlineimap/passw --output $HOME/.offlineimaprc --decrypt $HOME/Dropbox/backup_dell/sistema/rc/mutt/offlineimaprc_unfiltered.pgp
/usr/bin/offlineimap -o -u Noninteractive.Basic
sleep 2
wipe -f .offlineimaprc
