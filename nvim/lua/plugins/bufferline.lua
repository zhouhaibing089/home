return {
	"akinsho/bufferline.nvim",
	opts = {
		options = {
			indicator = {
				style = "none",
			},
			offsets = {
				{
					filetype = "neo-tree",
					text = "",
					text_align = "center", -- or "left" / "right"
				},
			},
			custom_filter = function(bufnr)
				local name = vim.api.nvim_buf_get_name(bufnr)
				if name == "" then
					return true
				end
				if vim.fn.isdirectory(name) == 1 then
					return false
				end
				return true
			end,
		},
	},
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
}
