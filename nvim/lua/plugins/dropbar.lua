return {
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar = require("dropbar")
			local bar_enable = require("dropbar.configs").opts.bar.enable
			dropbar.setup({
				bar = {
					enable = function(buf, win, info)
						if vim.bo[buf].filetype == "toggleterm" then
							return true
						end
						return bar_enable(buf, win, info)
					end,
					sources = function(_, _)
						return {
							require("dropbar.sources.path"),
							require("dropbar.sources.lsp"),
						}
					end,
				},
				sources = {
					path = {
						relative_to = function(_, _)
							if vim.w.cwd then
								return vim.fs.abspath(vim.w.cwd)
							elseif vim.t.cwd then
								return vim.fs.abspath(vim.t.cwd)
							else
								return vim.fn.getcwd()
							end
						end,
					},
				},
			})
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
}
