return {
	"akinsho/bufferline.nvim",
	opts = {
		options = {
			always_show_bufferline = false,
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
