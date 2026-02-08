vim.keymap.set("n", "<leader>nt", ":Neotree source=filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nr", function()
	local file = vim.fn.expand("%:p")
	require("neo-tree.command").execute({
		action = "focus", -- Focus the tree
		source = "filesystem", -- Use the filesystem source
		position = "float", -- Open in a floating window
		reveal_file = file, -- The specific file to highlight
		reveal_force_cwd = true, -- Change CWD if the file is outside the current root
	})
end, { desc = "Reveal file under cursor in Neo-tree" })
vim.api.nvim_create_autocmd("User", {
	pattern = "NeoTreeRootChanged",
	callback = function(args)
		vim.cmd("cd " .. args.data.path)
	end,
})
