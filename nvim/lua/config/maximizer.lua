local m = require("maximizer")
vim.keymap.set({ "n" }, "<leader>m", function()
	m.toggle()
end, { desc = "maximize current buffer" })
