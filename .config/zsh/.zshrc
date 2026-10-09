ZSH_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

export GH_PAGER=cat

##################   PROMPTS   ####################################
# # spaceship bootstrap (no framework, standalone)
# export SPACESHIP_CONFIG="$HOME/.config/zsh/spaceship.zsh"
# SPACESHIP_DIR="${ZDOTDIR:-$HOME/.config/zsh}/spaceship"
# if [[ ! -d "$SPACESHIP_DIR" ]]; then
#     git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_DIR"
# fi
# source "$SPACESHIP_DIR/spaceship.zsh"

# starship bootstrap
if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh
fi
export STARSHIP_CONFIG="${ZDOTDIR:-$HOME/.config/zsh}/starship.toml"
eval "$(starship init zsh)"

# # oh-my-posh bootstrap
# if ! command -v oh-my-posh &>/dev/null; then
# 	curl -s https://ohmyposh.dev/install.sh | bash -s
# fi
# eval "$(oh-my-posh init zsh --config $ZSH_CONFIG_HOME/omp.toml)"
##################   PROMPTS   ####################################

for file in "$ZSH_CONFIG_HOME/functions.d/"*.zsh; do
    source "$file"
done

# Zinit Bootstrap
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -U compinit && compinit

autoload -Uz edit-command-line
zle -N edit-command-line

# Plugins
zinit light hlissner/zsh-autopair
zinit light zap-zsh/sudo
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting
# --- Artisan ZSH integration
zinit ice wait lucid
zinit light jessarcher/zsh-artisan
compdef _artisan_add_completion artisan
# --- fzf-tab LAST
zinit light Aloxaf/fzf-tab
# --- Transient Prompt
zinit light olets/zsh-transient-prompt
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%F{#c6701a}%f '
TRANSIENT_PROMPT_TRANSIENT_RPROMPT='%F{240}%*%f'

# --- fzf shell integration
eval "$(fzf --zsh)"
# eval "$(symfony self:completion zsh)"

# Options
HISTFILE="$HOME/.config/zsh/history"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt NOTIFY
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Keybinds
bindkey -v
bindkey '^[[2~' edit-command-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^?" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey "^Y" autosuggest-accept
bindkey ' ' magic-space

# Styling
zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza -lhmogX --color=always --group-directories-first --icons $realpath'
zstyle ":fzf-tab:complete:artisan:*" fzf-preview \
'php $(find . -name artisan -maxdepth 2 | head -1) help \
	--ansi $word 2>/dev/null | bat \
	--language=help \
	--color=always \
	--plain 2>/dev/null \
	|| php $(find . -name artisan -maxdepth 2 | head -1) help \
	--ansi $word 2>/dev/null'

[[ -f "$XDG_CONFIG_HOME"/zsh/theme.zsh ]] && source "$XDG_CONFIG_HOME"/zsh/theme.zsh
[[ -f "$XDG_CONFIG_HOME"/alias ]] && source "$XDG_CONFIG_HOME"/alias

