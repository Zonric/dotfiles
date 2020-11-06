#!/usr/bin/env sh
export XDG_CONFIG_HOME="$HOME/.config"
export PS1="[\u \w]\$ "
export EDITOR="vim"
export VISUAL="atom"
export READER="zathura"
export TERMINAL="kitty"
export BROWSER="firefox"
export FILEMAN="ranger"
export PAGER="less"
export LESS="-x2R"
export VIMINIT="source ~/.config/vim/vimrc"

# NPM
NPM_PACKAGES="${HOME}/.npm/packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

if [ -d "$HOME/bin" ] ; then
	export PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$PATH:$(du $HOME/.local/bin | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
fi
# Adding Snap bins
if [ -d "/snap/bin" ] ; then
  export PATH="$PATH:/snap/bin"
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[ -f "$XDG_CONFIG_HOME/alias" ] && source "$XDG_CONFIG_HOME/alias"
