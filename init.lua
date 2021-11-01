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

use { 'hrsh7th/nvim-cmp',
	requires = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/cmp-buffer' }
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
--				{ name = 'buffer' }
			})
		})
	end,
}

vim.lsp.set_log_level('info')

use { 'neovim/nvim-lspconfig',
	requires = { {'lspcontainers/lspcontainers.nvim'} },
	config = function()
		local lsp = require('lspconfig')
		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(_, bufnr)
		  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		  -- Enable completion triggered by <c-x><c-o>
		  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

		  -- Mappings.
		  local opts = { noremap=true, silent=true }

		  -- See `:help vim.lsp.*` for documentation on any of the below functions
		  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
		  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
		  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
		  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
		  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
		  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
		end

		lsp.sumneko_lua.setup({
			cmd = require('lspcontainers').command('sumneko_lua', {
				image = 'lspcontainers/lua-language-server',
			}),
			on_attach = on_attach
		})

		lsp.yamlls.setup({
			before_init = function(params)
				params.processId = vim.NIL
			end,
			cmd = require('lspcontainers').command('yamlls'),
			root_dir = lsp.util.root_pattern(".git", vim.fn.getcwd()),
			on_attach = on_attach
		})

		lsp.jsonls.setup({
			before_init = function(params)
				params.processId = vim.NIL
			end,
			cmd = require('lspcontainers').command('jsonls'),
			root_dir = lsp.util.root_pattern(".git", vim.fn.getcwd()),
			on_attach = on_attach
		})

	end
}

