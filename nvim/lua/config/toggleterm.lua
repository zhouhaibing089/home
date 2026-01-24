vim.keymap.set("n", "<leader>tf", ":ToggleTerm 1 direction=float<CR>")
vim.keymap.set("n", "<leader>tb", ":ToggleTerm 2 direction=horizontal<CR>")
-- hopefully it doesn't interfere too much when I actually need <leader>tf or
-- <leader>tb in actual insert mode.
vim.keymap.set("t", "<leader>tf", "<C-\\><C-n>:ToggleTerm 1 direction=float<CR>")
vim.keymap.set("t", "<leader>tb", "<C-\\><C-n>:ToggleTerm 2 direction=horizontal<CR>")
