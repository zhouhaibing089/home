return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diagnostics" },
			lualine_c = {
				{
					function()
						local filename = vim.fn.expand("%:.")
						local cwd = vim.w.cwd or vim.t.cwd or ""
						if cwd == "" then
							return filename
						end
						if filename:sub(1, #cwd) == cwd then
							return filename:sub(#cwd + 2)
						end
						return filename
					end,
				},
			},

			lualine_x = {},
			lualine_y = {
				function()
					return vim.w.cwd or vim.t.cwd or ""
				end,
			},
			lualine_z = { "filetype" },
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
