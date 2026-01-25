return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = {},
		},
		inactive_sections = {
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
		},
		extensions = {
			"neo-tree",
			"toggleterm",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
