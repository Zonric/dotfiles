# Neovim Keymaps Quick Reference

A categorized cheatsheet of the active keybindings configured across `lua/config/keymaps/`.

- **Neovim Technical Guide**: [README.md](../README.md)
- **Dotfiles Master Guide**: [../../README.md](../../README.md)

---

## 1. Multicursor (`lua/config/keymaps/multicursor.lua`)

| Keymap | Mode | Description |
|---|---|---|
| `<C-n>` | `n`, `x` | Add cursor on next matching word / selection |
| `<C-s>` | `n`, `x` | Skip current match and select next |
| `<C-p>` | `n`, `x` | Add cursor on previous match |
| `<Up>` | `n`, `x` | Add cursor directly above |
| `<Down>` | `n`, `x` | Add cursor directly below |
| `<C-a>` | `n`, `x` | Add cursors to all matches in buffer |
| `<Esc>` | `n` | Clear multi-cursors / restore single cursor (or clear search highlight) |

---

## 2. Navigation & Window Controls (`lua/config/keymaps/navigation.lua`)

| Keymap | Mode | Description |
|---|---|---|
| `j` / `k` | `n`, `x` | Move up/down (respects wrapped lines when count = 0) |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | `n`, `t` | Navigate window splits (Left, Down, Up, Right) |
| `<C-A-h>` / `<C-A-l>` | `n` | Resize split vertically (-15 / +15) |
| `<C-A-j>` / `<C-A-k>` | `n` | Resize split horizontally (-1 / +1) |
| `<C-/>` | `n`, `t` | Toggle bottom terminal / Exit terminal mode |
| `<C-BS>` | `n` | Clear search highlight (`:nohlsearch`) |
| `<S-h>` / `<S-l>` | `n` | Cycle prev / next buffer |
| `<C-S-h>` / `<C-S-l>` | `n` | Move current buffer tab left / right |
| `<A-j>` / `<A-k>` | `n`, `v`, `i` | Move line(s) down / up |
| `<A-h>` / `<A-l>` | `n`, `v` | Decrease / increase line indentation |

---

## 3. LSP, Diagnostics & Snippets (`lua/config/keymaps/lsp.lua`)

| Keymap | Mode | Description |
|---|---|---|
| `gd` | `n` | Go to definition |
| `gD` | `n` | Go to declaration |
| `gr` | `n` | Go to references |
| `gi` | `n` | Go to implementation |
| `K` | `n` | Hover documentation |
| `<C-k>` | `i` | Signature help |
| `]d` / `[d` | `n` | Next / previous diagnostic |
| `]h` / `[h` | `n` | Next / previous git hunk |
| `]t` / `[t` | `n` | Next / previous todo comment |
| `<C-l>` / `<C-h>` | `i`, `s` | LuaSnip: Expand or jump forward / backward |
| `<C-n>` / `<C-p>` | `i`, `s` | LuaSnip: Cycle choice forward / backward |

---

## 4. Leader Keymaps (`lua/config/keymaps/leader.lua`)

### Core & Files
| Keymap | Mode | Description |
|---|---|---|
| `<leader>\` | `n` | Toggle file tree (`nvim-tree`) |
| `<leader>e` | `n` | Toggle file explorer (`mini.files`) |
| `<leader>bd` | `n` | Delete current buffer (keeps window open) |

### AI (`<leader>a...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>aa` | `n`, `v` | Action palette |
| `<leader>ac` | `n`, `v` | Toggle chat |
| `<leader>ai` | `n`, `v` | Inline assistant |
| `<leader>at` | `n`, `v` | Toggle CLI terminal |
| `<leader>ap` | `n`, `v` | Prompt input |
| `<leader>as` | `n`, `v` | TTS speak current line / selection |
| `<leader>aX` | `n` | TTS stop speaking |

### Code (`<leader>c...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>ca` | `n` | Code actions |
| `<leader>cc` | `n` | CodeCopy |
| `<leader>cu` | `n` | CodeCopy UI |
| `<leader>cf` | `n`, `v` | Format buffer / selection (`conform`) |
| `<leader>ce` | `n` | Diagnostics float |
| `<leader>cr` | `n` | Rename symbol |
| `<leader>ch` | `n` | Toggle inlay hints |

### Debug (`<leader>d...`)
| Keymap | Mode | Description |
|---|---|---|
| `<F8>` / `<leader>dc` | `n` | Start / Continue debug session |
| `<F9>` / `<leader>dn` | `n` | Step over |
| `<F10>` / `<leader>di` | `n` | Step into |
| `<F11>` / `<leader>do` | `n` | Step out |
| `<leader>db` / `<leader>dB` | `n` | Toggle breakpoint / Conditional breakpoint |
| `<leader>dq` | `n` | Terminate session |
| `<leader>du` / `<leader>dr` | `n` | Toggle DAP UI / Open REPL |
| `<leader>dd...` | `n` | Database UI operations |

### Find (`<leader>f...`) & Search (`<leader>s...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>ff` | `n` | Find files |
| `<leader>fb` | `n` | Find buffers |
| `<leader>fd` | `n` | Find diagnostics |
| `<leader>fh` | `n` | Help tags |
| `<leader>fk` | `n` | Keymaps |
| `<leader>fr` / `<leader>fs` | `n` | LSP references / symbols |
| `<leader>sf` | `n` | Live grep files |
| `<leader>sb` | `n` | Live grep current buffer |
| `<leader>sw` | `n` | Grep word under cursor |
| `<leader>st` | `n` | Todo comments |

### Git (`<leader>g...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>gb` / `<leader>gB` | `n` | Git branches / Git blame |
| `<leader>gc` | `n` | Commit logs |
| `<leader>gd` / `<leader>gD` | `n` | Diffview Open / Close |
| `<leader>gf` / `<leader>gs` | `n` | Diff files / Git status |
| `<leader>gl` | `n` | LazyGit |
| `<leader>gp` | `n` | Preview hunk |
| `<leader>ghs` / `<leader>ghr` | `n`, `v` | Stage hunk / Reset hunk |
| `<leader>ghu` | `n` | Undo / toggle stage hunk |

### Sessions (`<leader>q...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>qq` | `n` | Save project session & quit |
| `<leader>qs` | `n` | Save project session |
| `<leader>qr` | `n` | Restore project session (with shadow buffers) |
| `<leader>qd` | `n` | Delete project session |

### Test (`<leader>t...`) & Trouble (`<leader>x...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>tr` / `<leader>tf` | `n` | Run nearest test / current file tests |
| `<leader>td` / `<leader>tl` | `n` | Run directory tests / last test |
| `<leader>to` / `<leader>ts` | `n` | Open test output / toggle test summary |
| `<leader>xx` / `<leader>xb` | `n` | Project diagnostics / Buffer diagnostics |
| `<leader>xq` / `<leader>xs` | `n` | Quickfix list / Symbols |
| `<leader>xt` | `n` | Todo list |

### Notes / Second Brain (`<leader>n...`)
| Keymap | Mode | Description |
|---|---|---|
| `<leader>nn` | `n` | New permanent note (prompts for title) |
| `<leader>nd` | `n` | Daily note / capture today |
| `<leader>nf` | `n` | Find notes (`fzf-lua`) |
| `<leader>ns` | `n` | Grep note content (`fzf-lua`) |
| `<leader>nt` | `n` | Browse note tags (`fzf-lua`) |
| `<leader>nl` | `n` | Outgoing links from note |
| `<leader>nb` | `n` | Backlinks pointing to note |
| `<leader>nl` | `v` | Link selected text to existing note |
| `<leader>nn` | `v` | Create new note from selected text |
