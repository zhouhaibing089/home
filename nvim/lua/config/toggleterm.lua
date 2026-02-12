local Terminal = require("toggleterm.terminal").Terminal
local terms = {}

vim.keymap.set("n", "<leader>tf", function()
	local count = vim.fn.tabpagenr() * 10 + 1
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "float",
		})
	end
	terms[count].dir = vim.fn.getcwd()
	terms[count]:toggle()
end, { desc = "toggle floating terminal" })
vim.keymap.set("n", "<leader>tb", function()
	local count = vim.fn.tabpagenr() * 10 + 2
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "horizontal",
		})
	end
	terms[count].dir = vim.fn.getcwd()
	terms[count]:toggle()
end, { desc = "toggle bottom terminal" })
vim.keymap.set("n", "<leader>tF", function()
	local count = vim.fn.tabpagenr() * 10 + 1
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "float",
		})
	end
	terms[count].dir = vim.t.cwd or vim.fn.getcwd()
	terms[count]:toggle()
end, { desc = "toggle floating terminal under pinned dir" })
vim.keymap.set("n", "<leader>tB", function()
	local count = vim.fn.tabpagenr() * 10 + 2
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = "horizontal",
		})
	end
	terms[count].dir = vim.t.cwd or vim.fn.getcwd()
	terms[count]:toggle()
end, { desc = "toggle bottom terminal under pinned dir" })
