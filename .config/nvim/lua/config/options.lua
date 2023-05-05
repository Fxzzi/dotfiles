-- indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.autoindent = true
vim.o.smarttab = true

-- search and replace
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.gdefault = true
vim.o.showmatch = true

-- user interface
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.list = true
vim.o.showmode = false

-- editing
vim.o.completeopt = "menuone,noselect"
vim.o.shortmess = vim.o.shortmess..'c'
vim.o.inccommand = 'split'
vim.o.virtualedit = 'onemore'

-- timing and delays
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeout = true
vim.o.ttimeoutlen = 10
vim.o.updatetime = 50

-- file management
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.hidden = true

-- window management
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.mouse = 'a'
vim.o.winblend = 10

-- clipboard
vim.o.clipboard = "unnamedplus"
vim.o.pumblend = 10

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
