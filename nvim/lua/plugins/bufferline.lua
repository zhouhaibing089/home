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
		},
	},
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
}
