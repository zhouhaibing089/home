return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
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

			lualine_x = {
				function()
					if vim.w.cwd and vim.w.cwd == vim.t.cwd then
						return "[w][t] " .. vim.w.cwd
					end
					if vim.w.cwd then
						return "[w] " .. vim.w.cwd
					end
					if vim.t.cwd then
						return "[t] " .. vim.t.cwd
					end
					return ""
				end,
			},
			lualine_y = { "filetype" },
			lualine_z = {
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(0), ":t")
				end,
			},
		},
		inactive_sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
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
			lualine_x = {
				function()
					if vim.w.cwd and vim.w.cwd == vim.t.cwd then
						return "[w][t] " .. vim.w.cwd
					end
					if vim.w.cwd then
						return "[w] " .. vim.w.cwd
					end
					if vim.t.cwd then
						return "[t] " .. vim.t.cwd
					end
					return ""
				end,
			},
			lualine_y = { "filetype" },
			lualine_z = {
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(0), ":t")
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
