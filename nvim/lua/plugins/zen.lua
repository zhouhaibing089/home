return {
	"folke/zen-mode.nvim",
	opts = {
		on_open = function()
			vim.opt.cmdheight = 0
			vim.opt.showtabline = 0
		end,
		on_close = function()
			vim.opt.cmdheight = 1
			vim.opt.showtabline = 2
		end,
	},
}
