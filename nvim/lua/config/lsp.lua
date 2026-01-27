local fzf = require("fzf-lua")

vim.keymap.set("n", "gd", fzf.lsp_definitions)
vim.keymap.set("n", "gD", fzf.lsp_declarations)
vim.keymap.set("n", "gi", fzf.lsp_implementations)
vim.keymap.set("n", "gr", fzf.lsp_references, opts)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<C-k>", function()
	vim.lsp.buf.signature_help({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, opts)

-- set capabilities for all installed lsp servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end
