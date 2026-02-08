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
	local t = vim.g.t or {}
	nc.execute({
		action = "focus",
		source = "filesystem",
		position = "float",
		reveal = true,
		dir = t.cwd or vim.fn.getcwd(),
	})
end, { desc = "Reveal file under current working directory" })
-- This makes it faster when working in mono repository - like adding files or
-- delete files in current directory doesn't need a full travesal from project
-- root.
vim.keymap.set("n", "<leader>nR", function()
	nc.execute({
		action = "focus",
		source = "filesystem",
		position = "float",
		reveal = true,
		dir = vim.fn.expand("%:p:h"),
	})
end, { desc = "Reveal file under current directory" })
