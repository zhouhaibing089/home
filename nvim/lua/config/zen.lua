local zen = require("zen-mode")

vim.keymap.set({ "n" }, "<leader>z", function()
	zen.toggle({
		window = {
			width = 1,
		},
	})
end, { desc = "toggle zen mode - full width" })
vim.keymap.set({ "n" }, "<leader>Z", function()
	zen.toggle({
		window = {
			width = 120,
			backdrop = 0.4,
		},
	})
end, { desc = "toggle zen mode - small width" })
