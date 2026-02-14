-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- copy and paste
vim.keymap.set({ "x", "n" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "paste after from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "paste before from system clipboard" })
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
-- last yank goes to unnamed register as well as 0, to paste from last yank
-- reliably, I would like to have <leader>0. Don't confuse this with tab
-- switches as tab number is never 0. :)
vim.keymap.set("n", "<leader>0", '"0p', { desc = "paste from register 0" })

-- reload configuration
vim.keymap.set("n", "<leader>R", ":source $MYVIMRC<CR>", { desc = "reload configuration" })

-- center your cursor while search and move
vim.keymap.set("n", "n", "nzz", { desc = "next search result and center" })
vim.keymap.set("n", "N", "Nzz", { desc = "prev search result and center" })
vim.keymap.set("v", "<leader>/", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], {
	desc = "Search visual selection",
})

-- buffer view
vim.keymap.set("n", "<leader>j", "<C-d>zz", { desc = "half page down" })
vim.keymap.set("n", "<leader>k", "<C-u>zz", { desc = "half page up" })
vim.keymap.set("n", "<leader>i", "<C-i>", { desc = "go forward (in)" })
vim.keymap.set("n", "<leader>o", "<C-o>", { desc = "go backward (out)" })

-- clear highlights
vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	end
	return "<Esc>"
end, { expr = true, desc = "clear highlights if they exist" })

-- up/down selection in command completion
vim.opt.wildmode = { "longest:full", "full" }
vim.keymap.set("c", "<Up>", function()
	return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
end, { expr = true, noremap = true })
vim.keymap.set("c", "<Down>", function()
	return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
end, { expr = true, noremap = true })

-- switch tabs
vim.keymap.set("n", "<leader>1", "1gt", { desc = "go to tab1" })
vim.keymap.set("n", "<leader>2", "2gt", { desc = "go to tab2" })
vim.keymap.set("n", "<leader>3", "3gt", { desc = "go to tab3" })
vim.keymap.set("n", "<leader>4", "4gt", { desc = "go to tab4" })
vim.keymap.set("n", "<leader>5", "5gt", { desc = "go to tab5" })
vim.keymap.set("n", "<leader>6", "6gt", { desc = "go to tab6" })
vim.keymap.set("n", "<leader>7", "7gt", { desc = "go to tab7" })
vim.keymap.set("n", "<leader>8", "8gt", { desc = "go to tab8" })
vim.keymap.set("n", "<leader>9", "9gt", { desc = "go to tab9" })

-- splits
vim.keymap.set("n", "<leader>|", "<C-w>|", { desc = "take full width" })
vim.keymap.set("n", "<leader>_", "<C-w>_", { desc = "take full height" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "balance width or height" })
