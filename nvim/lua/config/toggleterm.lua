local Terminal = require("toggleterm.terminal").Terminal
local terms = {}

function toggle(offset, direction, dir)
	local count = vim.fn.tabpagenr() * 10 + offset
	if not terms[count] then
		terms[count] = Terminal:new({
			count = count,
			direction = direction,
		})
	end
	terms[count].dir = dir
	terms[count]:toggle()
end

vim.keymap.set("n", "<leader>tf", function()
	toggle(1, "float", vim.t.cwd or vim.fn.getcwd())
end, { desc = "toggle floating terminal" })
vim.keymap.set("n", "<leader>tb", function()
	toggle(2, "horizontal", vim.t.cwd or vim.fn.getcwd())
end, { desc = "toggle bottom terminal" })
vim.keymap.set("n", "<leader>tF", function()
	toggle(1, "float", vim.fn.expand("%:p:h"))
end, { desc = "toggle floating terminal from current buffer" })
vim.keymap.set("n", "<leader>tB", function()
	toggle(2, "horizontal", vim.fn.expand("%:p:h"))
end, { desc = "toggle bottom terminal from current buffer" })
vim.keymap.set("t", "<C-t>", function()
	local tt = require("toggleterm.terminal")
	local id = vim.b.toggle_number or tt.get_focused_id()
	if not id then
		return
	end
	local term = tt.get(id, true)
	if term then
		term:close()
	end
end, { desc = "close current terminal" })
