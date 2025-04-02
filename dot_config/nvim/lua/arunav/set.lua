local vim = vim

vim.g.mapleader = " "
vim.g.termguicolors = true
vim.g.background = "dark"
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '▏ ' }

vim.opt.signcolumn = "yes"
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"

vim.cmd.colorscheme("kanagawa")

