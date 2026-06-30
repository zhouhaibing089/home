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
			dropbar.setup({
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
