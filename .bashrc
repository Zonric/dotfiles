#!/usr/bin/env bash
stty -ixon
source /usr/share/powerline/bindings/bash/powerline.sh
[ -f $XDG_CONFIG_HOME/alias ] && source $XDG_CONFIG_HOME/alias
export VIMINIT="source ~/.config/vim/vimrc"
export HISTCONTROL=ignoreboth:erasedups
