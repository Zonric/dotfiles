--- Global Settings:
local g = vim.g
g.mapleader = " "
g.maplocalleader = "\\"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.php_indent_disable = 1

-- Server profile detection:
-- Enable via NVIM_SERVER=1 or creating ~/.config/nvim/.server
g.is_server = vim.env.NVIM_SERVER == "1"
	or vim.fn.filereadable(vim.fn.stdpath("config") .. "/.server") == 1

--- Dynamic Settings:
local opt = vim.opt
opt.encoding = "UTF-8"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.backspace = "indent,eol,start"
opt.mouse = "a"
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.hidden = true
opt.errorbells = false
opt.splitright = true
opt.splitbelow = true
opt.iskeyword:remove("_")

opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"

-- Folds
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.viewoptions = { "folds", "cursor", "curdir" }

-- Spelling
opt.spell = false
opt.spelllang = { "en_us" }

--- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false
opt.autoindent = true
opt.smartindent = true

--- Wrap & break
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakat = " "

--- UI settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.winborder = "rounded"
opt.laststatus = 3
--opt.colorcolumn = "100"
opt.showmode = false
opt.signcolumn = "yes"
opt.list = false
opt.cmdheight = 1
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--- Searching
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.undofile = true
opt.updatetime = 300
opt.timeoutlen = 500
opt.inccommand = "split"

vim.o.exrc = true
vim.cmd("syntax off")
