--[[

Neovim lua configuration.

--]]

require('packer').init()

vim.g.mapleader = ' '
vim.g.localleader = ','

local opt = vim.opt
-- general options
opt.hidden = true
opt.splitbelow = true
opt.splitright = true

vim.cmd([[
augroup Term
	autocmd!
	autocmd TermOpen * lua require('termopt')
augroup END
]])

-- line number options
opt.number = true
opt.signcolumn = 'number'
opt.relativenumber = true

-- tab options
--opt.tabstop = 2
--opt.shiftwidth = 2
--opt.softtabstop = 0
--opt.expandtab = false

local use = require('packer').use
use { 'wbthomason/packer.nvim' }
use { 'ggandor/lightspeed.nvim' }

use { 'RishabhRD/nvim-rdark',
	requires = { {'tjdevries/colorbuddy.vim'} },
	config = function()
		require('colorbuddy').colorscheme('nvim-rdark')
	end
}

use { 'folke/which-key.nvim',
	config = function()
		require('which-key').setup {

		}
	end
}

use { 'nvim-telescope/telescope.nvim',
	requires = { {'nvim-lua/plenary.nvim'} },
	config = function()
		require('telescope').setup {}
		vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
  	vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
  	vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
  	vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })
	end
}

use { 'nvim-treesitter/nvim-treesitter',
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = 'maintained',
			highlight = {
				enable = true
			},
			indent = {
				enable = true
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = 'gnn',
					node_incremental = 'grn',
					scope_incremental = 'grc',
					node_decremental = 'grm'
				}
			}
		}
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
	end,
	run = ':TSUpdate'
}

use { 'neovim/nvim-lspconfig',
	config = function()
		local lsp = require('lspconfig')

		require('lspconfig').sumneko_lua.setup({
			cmd = { 'sumneko', '-E', root_path .. "/main.lua" },
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
						path = runtime_path
					},
					diagnostics = {
						globals = { 'vim' }
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true)
					},
					telemetry = {
						enable = false
					}
				}
			}
		})
	end
}

