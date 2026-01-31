return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "gopls", "shfmt", "stylua" },
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
