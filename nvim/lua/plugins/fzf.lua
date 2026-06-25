return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {
		no_hide = true,
		winopts = {
			preview = { layout = "vertical", vertical = "down:50%" },
		},
		keymap = {
			builtin = {
				true,
				["<C-d>"] = "preview-page-down",
				["<C-u>"] = "preview-page-up",
			},
			fzf = {
				true,
				["ctrl-j"] = "down",
				["ctrl-k"] = "up",
			},
		},
		fzf_opts = {
			["--history"] = os.getenv("HOME") .. "/.fzf_history",
		},
		lsp = {
			symbols = {
				child_prefix = true,
				parent_postfix = ".",
			},
		},
	},
	---@diagnostic enable: missing-fields
}
