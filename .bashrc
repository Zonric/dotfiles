#!/usr/bin/env bash
stty -ixon
source /usr/share/powerline/bindings/bash/powerline.sh
source /home/zonric/.config/alias
export HISTCONTROL=ignoreboth:erasedups
export GPG_TTY=$(tty)

. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
