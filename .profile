#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2155,SC2086
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export MAKEFLAGS="-j$(nproc)"

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=wezterm
export BROWSER=firefox
export FILEMAN=ranger
export VISUALFILEMAN=thunar
export PAGER=less
export LESS=-x2R

export RANGER_LOAD_DEFAULT_RC=FALSE

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export ZDOTDIR=$HOME/.config/zsh
export GOPATH=$HOME/.go

export NVIMCONFIG=$HOME/.config/nvim/init.lua
export QT_STYLE_OVERRIDE=kvantum

umask 002

numlockx

# Conditional $PATH adds:
if [ -d $HOME/.local/bin ]; then
	export PATH="$PATH:$(du $HOME/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
fi
if [ -d $HOME/.config/composer/vendor/bin ]; then
	export PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi
if [ -d $HOME/.dotnet/tools ]; then
	export PATH="$PATH:$HOME/.dotnet/tools"
fi

[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f "$XDG_CONFIG_HOME/alias" ] && source "$XDG_CONFIG_HOME/alias"

#. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
