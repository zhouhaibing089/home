return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"clangd",
			"gopls",
			"pyright",
			"ruff",
			"rust_analyzer",
			"terraformls",
			"lua_ls",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
