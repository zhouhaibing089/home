return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		opts = {
			window = {
				position = "float",
			},
			sources = { "filesystem", "buffers" },
			filesystem = {
				bind_to_cwd = false,
				hijack_netrw_behavior = "disabled", -- don't show by default
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
	},
}
