return {
	"f-person/auto-dark-mode.nvim",
	opts = {
		set_dark_mode = function()
			vim.api.nvim_set_option_value("background", "dark", {})
			vim.api.nvim_set_hl(0, "AerialLine", {
				bg = "#073642",
				fg = "#93a1a1",
				bold = true,
			})
		end,
		set_light_mode = function()
			vim.api.nvim_set_option_value("background", "light", {})
			vim.api.nvim_set_hl(0, "AerialLine", {
				bg = "#eee8d5",
				fg = "#586e75",
				bold = true,
			})
		end,
	},
}
