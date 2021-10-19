-- tab options
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 0
vim.bo.expandtab = false

use { 'neovim/nvim-lspconfig',
	config = function()
		require('lspconfig').sumneko_lua.setup({

		})
	end
}
