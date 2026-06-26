return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			globalstatus = true,
			icons_enabled = true,
			disabled_filetypes = {
				winbar = {
					"toggleterm",
				},
			},
		},
		winbar = {
			lualine_c = {
				{
					function()
						local filename = vim.fn.expand("%")
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
			lualine_z = {
				function()
					if vim.w.cwd and vim.w.cwd ~= vim.t.cwd then
						return vim.w.cwd
					end
					return ""
				end,
			},
		},
		inactive_winbar = {
			lualine_c = {
				{
					function()
						local filename = vim.fn.expand("%")
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
			lualine_z = {
				function()
					if vim.w.cwd and vim.w.cwd ~= vim.t.cwd then
						return vim.w.cwd
					end
					return ""
				end,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {},

			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = {
				function()
					return vim.t.cwd or ""
				end,
			},
		},
		inactive_sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {},

			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = {
				function()
					return vim.t.cwd or ""
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
