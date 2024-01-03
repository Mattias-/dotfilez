vim.g.mapleader = ' '
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.listchars = {
    space = "·",
    trail = "·",
    tab = "▸ ",
    nbsp = "␣",
    precedes = "«",
    extends = "»",
    eol = "↲",
}

vim.o.completeopt = "menu,menuone,noselect"
