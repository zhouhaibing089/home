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

			lualine_x = {
				function()
					vim.g.t = vim.g.t or {}
					return vim.g.t.cwd or ""
				end,
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = {
				function()
					vim.g.t = vim.g.t or {}
					return vim.g.t.cwd or ""
				end,
			},
		},
		extensions = {
			"neo-tree",
			"toggleterm",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
