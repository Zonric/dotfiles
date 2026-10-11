# Neovim Configuration (`~/.config/nvim`)

An extensible, high-performance Neovim setup centered on native Lua, lazy loading, LSP integration, Tree-sitter enhancements, debugging (DAP), AI assistance, and safe modular keymaps.

Part of the personal [Dotfiles Repository](../../README.md).

---

## Architecture & Directory Layout

```text
~/.config/nvim/
├── init.lua                   # Entrypoint; sequentially loads core modules
├── lazy-lock.json             # Pinned plugin commit hashes
├── queries/                   # Custom Tree-sitter query overrides
├── scripts/                   # Utility and bootstrapping scripts
├── snippets/                  # Custom snippets
├── colors/                    # Custom highlight definitions
├── docs/                      # Documentation & cheatsheets
│   ├── keymaps-cheatsheet.md  # Keybindings reference guide
│   └── ...
└── lua/
    ├── config/                # Core editor configuration
    │   ├── options.lua        # Editor options (tabs, line numbers, clipboard, UI)
    │   ├── lazy.lua           # lazy.nvim package manager bootstrapping & config
    │   ├── autocmd.lua        # Global autocommands
    │   ├── diagnostics.lua    # Diagnostic signs, virtual text, and float styling
    │   ├── formatting.lua     # Formatting definitions
    │   ├── lsp.lua            # Global LSP capabilities, handlers, and servers
    │   ├── dap.lua            # DAP adapter settings
    │   ├── statusline.lua     # Statusline styling
    │   ├── agents.lua         # AI / Agent interaction and TTS helper
    │   └── keymaps/           # Modularized keymaps engine
    │       ├── init.lua       # Auto-loader: discovers & loads all keymap domains
    │       ├── util.lua       # `safe()` pcall caller and which-key group helpers
    │       ├── multicursor.lua# Multi-cursor controls and smart <Esc> fallback
    │       ├── navigation.lua # Window splits, Alt movement, terminals, resizes
    │       ├── lsp.lua        # LSP jump, hover, diagnostics, LuaSnip, Rust/Crates
    │       ├── leader.lua     # <leader> domains (AI, Code, Find, Git, Test, Trouble)
    │       └── session.lua    # Project session manager with dirty buffer shadow snapshots
    └── plugins/               # lazy.nvim plugin specifications
        ├── agents.lua         # CodeCompanion / AI assistant integrations
        ├── completion.lua     # Completion engine (nvim-cmp / minuet / blink)
        ├── dap.lua            # Debug Adapter Protocol (nvim-dap, dap-ui, virtual text)
        ├── database.lua       # Dadbod / Dadbod-UI database tooling
        ├── editing.lua        # multicursor.nvim, autopairs, autotag, surround, flash
        ├── formatting.lua     # conform.nvim formatters
        ├── git.lua            # gitsigns, diffview, lazygit
        ├── lsp.lua            # nvim-lspconfig, mason, mason-lspconfig
        ├── syntax.lua         # nvim-treesitter, context, textobjects
        ├── testing.lua        # neotest and test runners
        ├── themes.lua         # Colorschemes (Nightfox, Catppuccin, etc.)
        └── ui.lua             # fzf-lua, bufferline, lualine, mini.files, nvim-tree
```

---

## Core Systems & Highlights

### 1. Safe & Modular Keymaps Engine (`lua/config/keymaps/`)
Keymaps are completely decoupled from plugin specifications. They reside in `lua/config/keymaps/` and are organized by functional domain.

- **Auto-Discovery (`init.lua`)**: Dynamically scans and loads every `.lua` file inside `lua/config/keymaps/` without needing manual registration.
- **Lazy & Call Safety (`util.lua`)**: Provides a `safe(mod, fn_or_str)` execution helper. If a plugin is uninstalled, disabled, or fails to load, keybindings silently exit without crashing Neovim or throwing Lua errors.
- **Cheat Sheet**: Complete keymap table is documented in [`docs/keymaps-cheatsheet.md`](docs/keymaps-cheatsheet.md).

### 2. Multi-Cursor Editing (`multicursor.nvim`)
Modern Lua-native multi-cursor support:
- `<C-n>`: Add cursor on next word/selection match.
- `<C-s>`: Skip match and jump to next.
- `<C-p>`: Add cursor on previous match.
- `<Up>` / `<Down>`: Vertically stack cursors across rows.
- `<C-a>`: Match all occurrences buffer-wide.
- `<Esc>`: Dismisses multi-cursors first before falling back to clearing search highlights (`nohlsearch`).

### 3. Session Persistence with Dirty Buffer Shadowing (`session.lua`)
Enhanced project-level session restoration:
- `<leader>qq`: Save project layout, snapshot modified dirty buffer states to state cache, and quit.
- `<leader>qs`: Save project layout without quitting.
- `<leader>qr`: Restore project session layout and re-inject modified buffer content snapshots.
- `<leader>qd`: Wipe saved project session cache.

### 4. LSP, Formatting & Diagnostics
- **LSP Management**: Mason + `nvim-lspconfig` + `rustaceanvim`.
- **Formatting**: `conform.nvim` with fallback and asynchronous capability via `<leader>cf`.
- **Diagnostics & Error Navigation**: Inline diagnostics, jump brackets `]d`/`[d`, floating viewer `<leader>ce`, and `trouble.nvim` diagnostics workspace panel via `<leader>xx`.

### 5. Fuzzy Finding & UI Navigation
- **Fuzzy Finder**: `fzf-lua` powering `<leader>f...` (files, buffers, diagnostics, tags) and `<leader>s...` (live grep, cword, todo comments).
- **File Trees**: `nvim-tree` on `<leader>\` and lightweight modal navigator `mini.files` on `<leader>e`.

### 6. Second Brain & Thought Documentation (`zk-nvim` + `fzf-lua` + LSP)
Lightweight, plenary-free, interconnected Zettelkasten knowledge base in `~/notes`:
- **LSP Intelligence**: Language server integration (`zk lsp`) brings real-time backlinks, autocompleting `[[wikilinks]]`, and `gd` definition jumps directly to linked thoughts.
- **`fzf-lua` Picker**: Fast note filtering (`<leader>nf`), grep search (`<leader>ns`), and tag exploration (`<leader>nt`).
- **Capture Workflow**: Daily thoughts via `<leader>nd`, atomic permanent notes via `<leader>nn`, and bidirectional link injection with visual `<leader>nl`.

---

## Requirements

- **Neovim**: `>= 0.10.0`
- **C Compiler & Build Tools**: `gcc` / `clang`, `make`, `cmake` (for Tree-sitter parsers)
- **Git** & **curl** (for lazy.nvim bootstrapping)
- **External CLI Tools**:
  - `fzf`
  - `ripgrep` (`rg`)
  - `fd`
