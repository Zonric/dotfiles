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
export GOPATH=$HOME/.go

export ZDOTDIR=$HOME/.config/zsh
export NVIM_DIR="$HOME/.config/nvm"
export NVIM_CONFIG=$HOME/.config/nvim/init.lua

umask 002

numlockx

[ -d $HOME/.local/bin ] && export PATH="$PATH:$(du $HOME/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
[ -d $HOME/.config/composer/vendor/bin ] && export PATH="$PATH:$HOME/.config/composer/vendor/bin"
[ -d $HOME/.dotnet/tools ] && export PATH="$PATH:$HOME/.dotnet/tools"

[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
[ -f $XDG_CONFIG_HOME/alias ] && source $XDG_CONFIG_HOME/alias

[ -s $NVM_DIR/nvm.sh ] && source $NVM_DIR/nvm.sh
[ -s $NVM_DIR/bash_completion ] && source $NVM_DIR/bash_completion # This loads nvm bash_completion

