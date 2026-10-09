#!/usr/bin/env bash

export XDG_CONFIG_HOME="$HOME/.config"
export XKB_DEFAULT_OPTIONS=caps:escape

export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=ghostty
export BROWSER=firefox
export FILEMAN=yazi
export VISUALFILEMAN=pcmanfm-qt
export PAGER=less
export LESS=-x2R
export HISTFILE="$HOME/.cache/bash_history"

NPROC=$(nproc)
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export MAKEFLAGS="-j$NPROC"
export CMAKE_GENERATOR="Ninja Multi-Config"
export VCPKG_ROOT="$HOME/.local/share/vcpkg"

export STOW_DIR="$HOME/.dotfiles"

export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export GOCACHE="$HOME/.cache/go"
export GOENV="$HOME/.config/go/env"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export NVIM_DIR="$XDG_CONFIG_HOME/nvim"
export NVIM_CONFIG="$NVIM_DIR/init.lua"
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"

if [[ -z "$DBUS_SESSION_BUS_ADDRESS" ]]; then
	eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Setup local paths in PATH
LOCALBINSUBDIR=$(du "$HOME"/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$LOCALBINSUBDIR"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$PATH:$HOME/.cargo/bin"
[[ -d "$XDG_CONFIG_HOME/composer/vendor/bin" ]] && export PATH="$PATH:$XDG_CONFIG_HOME/composer/vendor/bin"

[[ -f "$XDG_CONFIG_HOME/wacom/config" ]] && source "$XDG_CONFIG_HOME/wacom/config"

if command -v fontpreview >/dev/null && [ -f "$XDG_CONFIG_HOME/fontconfig/preview.txt" ]; then
	export FONTPREVIEW_PREVIEW_TEXT="$(cat ~/.config/fontconfig/preview.txt)"
	export FONTPREVIEW_FONT_SIZE=14
	export FONTPREVIEW_BG_COLOR="#1e1e2e"
	export FONTPREVIEW_FG_COLOR="#cdd6f4"
fi

# Podman socket for Docker-compatible tools (lazydocker, etc.)
export DOCKER_HOST="unix://${XDG_RUNTIME_DIR:-/run/user/1000}/podman/podman.sock"

umask 002
