require("nvim-treesitter").install({ "terraform", "hcl", "c", "python", "go", "rust", "lua" })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
