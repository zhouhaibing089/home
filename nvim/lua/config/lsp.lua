local fzf = require("fzf-lua")

-- These are the most significant keybindings, so making it short
vim.keymap.set("n", "<leader>d", fzf.lsp_definitions)
vim.keymap.set("n", "<leader>D", fzf.lsp_declarations)
vim.keymap.set("n", "<leader>i", fzf.lsp_implementations)
vim.keymap.set("n", "<leader>r", fzf.lsp_references)
vim.keymap.set("n", "<leader>e", fzf.diagnostics_document)
vim.keymap.set("n", "<leader>E", fzf.diagnostics_workspace)
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<leader>H", function()
	vim.lsp.buf.signature_help({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename)
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
