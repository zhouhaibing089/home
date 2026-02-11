local Terminal = require("toggleterm.terminal").Terminal
local terms = {}

vim.keymap.set("n", "<leader>tf", function()
	local count = vim.fn.tabpagenr() * 10 + 1
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "float",
			dir = vim.fn.getcwd(),
		})
	end
	terms[count]:toggle()
end)
vim.keymap.set("n", "<leader>tb", function()
	local count = vim.fn.tabpagenr() * 10 + 2
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "horizontal",
			dir = vim.fn.getcwd(),
		})
	end
	terms[count]:toggle()
end)
