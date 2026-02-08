local nc = require("neo-tree.command")

vim.keymap.set("n", "<leader>nt", function()
	local t = vim.g.t or {}
	nc.execute({
		action = "focus",
		source = "filesystem",
		position = "float",
		toggle = true,
		dir = t.cwd or vim.fn.getcwd(),
	})
end, { desc = "Toggle neo-tree" })
vim.keymap.set("n", "<leader>nr", function()
	nc.execute({
		action = "focus",
		source = "filesystem",
		position = "float",
		reveal = true,
		dir = vim.fn.expand("%:p:h"),
	})
end, { desc = "Reveal file under cursor" })
