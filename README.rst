==================
fradeve's dotfiles
==================

This repo has been structured to be used with GNU Stow.
The following software is *dotfiled* in this repo:

Xorg and WM
===========

* X11
* i3
* Dunst
* xbindkeys
* zathura
* feh
* Rofi, rofi-pass

Text editor
===========

* LaTeXMk
* VIM

Terminal
========

* Zsh
* st
* Tmux (with Tmuxp_)
* Powerline_

Music
=====

* Mpd
* Ncmpcpp
* Beets_

Mail, news, IM
==============

* Mutt
* Offlineimap
* vdirsyncer
* khard
* Newsbeuter

CVS
===

* GIT

ArchLinux
=========

* fabric.py

GTD
===

* TaskWarrior
* TimeWarrior

Misc
====

* Cups
* Docker
* GnuPG

When program's settings depend from another software, or when installation is
quite complicated, an ``INSTALL`` file is provided. When a program needs some
passwords in the ``rc`` file, an ``example`` folder has been added with some
samples of rc files.


Notes to self
=============

* given the provided ``.stowrc``, all settings in all folders are referred to
  ``$HOME``
* the only exception is the ``_devs``, containing device-specific settings; to
  use them, just put yourself in the right device folder and specify the current 
  folder as a Stow directory, e.g.:

  .. code-block::

     cd _devs/duck
     stow -d . beet

  to install Beets configuration.


.. _dircolors-solarized: https://github.com/seebi/dircolors-solarized
.. _Tmuxp: https://github.com/tony/tmuxp
.. _Powerline: https://github.com/Lokaltog/powerline
.. _Beets: https://github.com/sampsyo/beets

