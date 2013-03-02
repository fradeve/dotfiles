#!/bin/bash
rm $HOME/.bin/pacman*
yaourt -B $HOME/.bin
mv $HOME/.bin/pacman* $HOME/.bin/pacman_pkg_latest.tar.bz2
