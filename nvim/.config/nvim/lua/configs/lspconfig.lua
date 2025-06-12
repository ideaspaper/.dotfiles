local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

lspconfig.servers = {
	"lua_ls",
	"gopls",
	"ts_ls",
	"pylsp",
	"jsonls",
	"yamlls",
}

local default_servers = {}

for _, lsp in ipairs(default_servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				enable = false,
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/love2d/library",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
