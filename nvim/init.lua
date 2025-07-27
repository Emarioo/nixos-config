require('telescope').setup{}

require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  }
}
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files({ hidden = true })
end, { desc = 'Find files (including hidden)' })

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Spaces and tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- Syntax highlighting and plugins
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Matching parentheses
vim.opt.showmatch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Search improvements
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Undo history
vim.opt.undofile = true

-- Disable annoying bell
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Hidden buffers
vim.opt.hidden = true

-- Backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }
