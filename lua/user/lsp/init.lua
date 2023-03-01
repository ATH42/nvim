local status_ok, _ = pcall(require, "lspconfig")
local util = require("lspconfig/util")

if not status_ok then
	return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

require("lspconfig").svelte.setup({})
require("lspconfig").astro.setup({})

require("lspconfig").gopls.setup({
	on_attach = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		vim.keymap.set("n", "gl", vim.diagnostic.open_float)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
	end,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})
