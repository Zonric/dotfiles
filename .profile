#!/usr/bin/env bash
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="vim"
export VISUAL="atom"
export TERMINAL="kitty"
export BROWSER="firefox"
export FILEMAN="ranger"
export PAGER="less"
export LESS="-x2R"

umask 002

if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$PATH:$(du $HOME/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
fi

[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f "$XDG_CONFIG_HOME/alias" ] && source "$XDG_CONFIG_HOME/alias"

. "$HOME/.cargo/env"
