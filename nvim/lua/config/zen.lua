local zen = require("zen-mode")

vim.keymap.set({ "n" }, "<leader>z", function()
	zen.toggle({
		window = {
			width = 1,
			options = {
				winbar = "%{%v:lua.dropbar()%}",
			},
		},
	})
end, { desc = "toggle zen mode - full width" })
