-- Nvim-tree settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup()

vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<c-f>', ':NvimTreeFocus<CR>', {})

vim.keymap.set('i', 'jl', '<esc>l', {})
vim.keymap.set('v', 'jl', '<esc>', {})
