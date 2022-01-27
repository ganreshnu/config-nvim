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
opt.tabstop = 3
opt.shiftwidth = 3
opt.softtabstop = 3
opt.expandtab = false

local use = require('packer').use
use { 'wbthomason/packer.nvim' }
use { 'ggandor/lightspeed.nvim' }

--use { 'tomasiser/vim-code-dark',
--	config = function()
--		vim.cmd('colorscheme codedark')
--	end
--}

use { 'folke/which-key.nvim',
	config = function()
		require('which-key').setup {}
	end
}

use { 'nvim-telescope/telescope.nvim',
	requires = { {'nvim-lua/plenary.nvim'} },
	config = function()
		require('telescope').setup {}
		vim.api.nvim_set_keymap('n', '<leader>fF', '<cmd>Telescope find_files<cr>', { noremap = true })
		vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope git_files<cr>', { noremap = true })
		vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
		vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
		vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })
	end
}

--use { 'nvim-treesitter/nvim-treesitter',
--	config = function()
--		require('nvim-treesitter.configs').setup {
--			ensure_installed = 'maintained',
--			highlight = {
--				enable = true
--			},
--			indent = {
--				enable = true
--			},
--			incremental_selection = {
--				enable = true,
--				keymaps = {
--					init_selection = 'gnn',
--					node_incremental = 'grn',
--					scope_incremental = 'grc',
--					node_decremental = 'grm'
--				}
--			}
--		}
--		vim.opt.foldmethod = 'expr'
--		vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--	end,
--	run = ':TSUpdate'
--}

use { 'hrsh7th/nvim-cmp',
	requires = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'saadparwaiz1/cmp_luasnip',
			requires = {
				{ 'L3MON4D3/LuaSnip' }
			}
		},
	},
	config = function()
--		vim.opt.completeopt = 'menuone,noselect'
		local cmp = require('cmp')
		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end
			},
			formatting = {
--				format = require('lspkind').cmp_format({ with_text = true })
				format = function(entry, vim_item)
					vim_item.menu = entry.source.name
					return vim_item
				end
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
--				{ name = 'buffer' }
			})
		})
	end
}

--vim.lsp.set_log_level('info')

--use {
--	'lewis6991/gitsigns.nvim',
--	requires = {
--		'nvim-lua/plenary.nvim'
--	},
--	config = function()
--		require('gitsigns').setup()
--	end
--}

--use {
--	'glepnir/lspsaga.nvim',
--	config = function()
--		local saga = require('lspsaga')
--		saga.init_lsp_saga {
--
--		}
--	end
--}

use { 'neovim/nvim-lspconfig',
	config = function()
		vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients(), true)<cr>', { noremap = true })
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
		  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
		  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
		  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
		  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
		  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
		  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
		  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
		end

		local before_init = function(params)
			params.processId = vim.NIL
		end

		local container_cmd = function(params)
			local defaults = {
				chdir = false,
				volumes = {},
				image = nil,
				args = nil
			}
			local p = vim.tbl_extend("force", defaults, params)
			local workdir = vim.fn.getcwd()
			local cmd = {
				"docker",
				"run",
				"--interactive",
				"--rm",
			}
			if p.chdir then
				table.insert(cmd, "--workdir="..workdir)
			end
			table.insert(cmd, "--volume="..workdir..":"..workdir..":ro")
			for vol, option in ipairs(p.volumes) do
				table.insert(cmd, "--volume="..vol..":"..vol..option)
			end
			table.insert(cmd, p.image)
			if p.args then
				table.insert(cmd, p.args)
			end

			return vim.tbl_flatten(cmd)
		end

		local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

		lsp.sumneko_lua.setup({
			cmd = container_cmd({
				volumes = {
					[vim.fn.expand('$VIMRUNTIME')] = ":ro",
					[vim.fn.expand('~/.local/share/nvim')] = ":ro"
				},
				image = "lspcontainers/lua-language-server",
			}),
			before_init = before_init,
			on_attach = on_attach,
			capabilities = capabilities,
			-- default settings, can be overridden by a .luarc.json file
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
						path = {
							"?.lua",
							"?/init.lua",
							"lua/?.lua",
							"lua/?/init.lua"
						}
					},
					diagnostics = {
						globals = { 'vim' }
					},
					workspace = {
						library = {
							vim.fn.expand('$VIMRUNTIME'),
							vim.fn.expand('~/.local/share/nvim')
						}
					},
					telemetry = {
						enable = false
					}
				}
			}
		})

		lsp.yamlls.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/yaml-language-server",  "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.pyright.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/pyright-langserver", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.html.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/html-languageserver", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.dockerls.setup({
			cmd = container_cmd({
				image = "rcjsuen/docker-langserver",
				args =  { "--stdio" }
			}),
			on_attach = on_attach,
			capabilities = capabilities,
			before_init = before_init,
			root_dir = (function(_) return vim.fn.getcwd() end)
		})

		lsp.cssls.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/css-languageserver", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.jsonls.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/vscode-json-languageserver", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.bashls.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/bash-language-server", "start" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.tsserver.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/typescript-language-server", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.intelephense.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/intelephense", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.vuels.setup({
			cmd = container_cmd({
				image = "node-language-servers",
				args = { "/usr/local/bin/vls", "--stdio" }
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.clangd.setup({
			cmd = container_cmd({
				image = "buildtool",
				args = { "/usr/bin/clangd", "--background-index", "--compile-commands-dir=build", "--clang-tidy" },
				volumes = {
					[vim.fn.getcwd().."/.cache"] = nil
				}
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

		lsp.gopls.setup({
			cmd = container_cmd({
				image = "lspcontainers/gopls",
				args = { "/root/go/bin/gopls" },
			}),
			on_attach = on_attach,
			before_init = before_init,
			capabilities = capabilities
		})

	end
}

