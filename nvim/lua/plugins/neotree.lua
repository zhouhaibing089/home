return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		opts = {
			window = {
				position = "left",
				width = 60,
				auto_expand_width = true,
			},
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			filesystem = {
				use_libuv_file_watcher = true,
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
