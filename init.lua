--[[

Neovim lua configuration.

--]]

vim.g.mapleader = ' '
vim.g.localleader = ','

local opt = vim.opt
-- general options
opt.hidden = true
opt.splitbelow = true
opt.splitright = true

-- line number options
opt.number = true
opt.signcolumn = 'number'
opt.relativenumber = true

-- tab options
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
opt.expandtab = false

