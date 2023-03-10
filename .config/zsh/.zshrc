export ZSH="$ZDOTDIR/ohmyzsh"
HYPHEN_INSENSITIVE="true"

plugins=(git-prompt dotenv virtualenv)

source $ZSH/oh-my-zsh.sh
source $ZSH/../custom.zsh-theme
source $XDG_CONFIG_HOME/alias

export LANG=en_US.UTF-8

# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
