#git super status
if [ ! -d "$XDG_CONFIG_HOME/zsh/git-prompt-zsh" ]; then
	git clone https://gethub.com/Zonric/git-prompt-zsh.git $XDG_CONFIG_HOME/zsh/git-prompt-zsh
fi
source $XDG_CONFIG_HOME/zsh/git-prompt-zsh/git-prompt.zsh
ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM="full"

ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{magenta}  %f%b"
ZSH_THEME_GIT_PROMPT_SUFFIX="›"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" ‹"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[yellow]%} 󰪅"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_no_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[cyan]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}󰄬"

PROMPT=$'%F{green}╒ %f%(?..%F{red}%? %f )%B%F{blue}%~%f%b$(gitprompt)\n%F{green}╘ %f%F{green}➢%f '
RPROMPT='${date}'

export NVM_DIR="$HOME/.config/nvm"

zstyle ':completion:*' completer _expand _complete
unsetopt hist_verify

[ -f ~/.config/alias ] && source ~/.config/alias
[ -S "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
