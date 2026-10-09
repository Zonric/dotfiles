# Dotfiles

Personal system configurations managed using a bare Git repository.

## Setup & Workflow

This repository uses the bare repository pattern where Git metadata resides in `~/.dotfiles` and the working tree is `$HOME`.

### Alias Definition

Add the alias to your shell configuration (`~/.zshrc`, `~/.bashrc`, or `~/.profile`):

```bash
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

### Essential Settings

Prevent Git from showing all untracked files in `$HOME`:

```bash
cfg config --local status.showUntrackedFiles no
```

## Day-to-Day Usage

```bash
# Check status of tracked files
cfg status

# Stage a modified or new configuration
cfg add ~/.config/nvim/init.lua

# Commit changes
cfg commit -m "feat(nvim): update init config"

# Push to remote repository
cfg push origin master
```

## Replicating on a Fresh Machine

```bash
# 1. Clone bare repository
git clone --bare <git-repo-url> $HOME/.dotfiles

# 2. Define alias for the active session
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Suppress untracked files display
cfg config --local status.showUntrackedFiles no

# 4. Checkout configs into home directory
cfg checkout
```

> **Note**: If `cfg checkout` warns about existing conflicting files (e.g. stock default `.profile` or `.bashrc`), backup conflicting files before retrying:
>
> ```bash
> mkdir -p ~/.dotfiles/backup && \
>   cfg checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' | \
>   xargs -I{} mv -v "$HOME/{}" "$HOME/.dotfiles/backup/" && \
>   cfg checkout
> ```

## Included Configurations

- **Shell & Environment**:
  - `~/.profile` (canonical login session profile)
  - `~/.zprofile` -> symlink to `.profile`
  - `~/.bash_profile` -> symlink to `.profile`
  - `~/.config/zsh/` (`.zshrc`, Starship, Oh My Posh, Spaceship configs)
  - `~/.config/alias`
- **Editor**: Neovim (`~/.config/nvim`)
- **Window Manager & Desktop**: Hyprland (`~/.config/hypr`) & MangoWM (`~/.config/mango`)
- **Bar & Widgets**: Waybar (`~/.config/waybar`)
- **Terminal**: Ghostty (`~/.config/ghostty`)
