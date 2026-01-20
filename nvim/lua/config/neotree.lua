vim.keymap.set("n", "<leader>nt", ":Neotree source=filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nr", ":Neotree source=filesystem reveal<CR>")
vim.api.nvim_create_autocmd("User", {
	pattern = "NeoTreeRootChanged",
	callback = function(args)
		vim.cmd("cd " .. args.data.path)
	end,
})
