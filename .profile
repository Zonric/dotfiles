#!/usr/bin/env bash

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export MAKEFLAGS="-j$(expr $(nproc))"

export EDITOR=nvim
export VISUAL=code
export TERMINAL=kitty
#export BROWSER=brave-browser-nightly
export BROWSER=firefox
export FILEMAN=ranger
export VISUALFILEMAN=ranger
export PAGER=less
export LESS=-x2R

export RANGER_LOAD_DEFAULT_RC=FALSE

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export ZDOTDIR=$HOME/.config/zsh
export GOPATH=$HOME/.go

umask 002

numlockx

if [ -d $HOME/.local/bin ] ; then
	export PATH="$PATH:$(du $HOME/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
fi

export PATH="$PATH:$HOME/.config/composer/vendor/bin"

[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f "$XDG_CONFIG_HOME/alias" ] && source "$XDG_CONFIG_HOME/alias"

#. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"	# This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"	# This loads nvm bash_completion
