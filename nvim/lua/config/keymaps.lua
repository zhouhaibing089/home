-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- copy and paste
vim.keymap.set("x", "<leader>y", '"+y', { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "paste from system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>cp", ':let @+ = expand("%:p")<CR>', { desc = "copy full path of current buffer" })
vim.keymap.set(
	{ "n", "x" },
	"<leader>cr",
	':let @+ = expand("%:p:.")<CR>',
	{ desc = "copy relative path of current buffer" }
)
vim.keymap.set(
	{ "n", "x" },
	"<leader>cd",
	':let @+ = expand("%:p:.:h")<CR>',
	{ desc = "copy relative directory of current buffer" }
)

-- reload configuration
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "reload configuration" })

-- center your cursor while search and move
vim.keymap.set("n", "n", "nzz", { desc = "next search result and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "prev search result and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
