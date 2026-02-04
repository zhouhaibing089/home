local fzf = require("fzf-lua")
local conform = require("conform")

-- These are the most significant keybindings, so making it short
vim.keymap.set("n", "<leader>d", fzf.lsp_definitions, { desc = "definitions" })
vim.keymap.set("n", "<leader>D", fzf.lsp_declarations, { desc = "declarations" })
vim.keymap.set("n", "<leader>i", fzf.lsp_implementations, { desc = "implementations" })
vim.keymap.set("n", "<leader>r", fzf.lsp_references, { desc = "references" })
vim.keymap.set("n", "<leader>e", fzf.diagnostics_document, { desc = "document diagnostics" })
vim.keymap.set("n", "<leader>E", fzf.diagnostics_workspace, { desc = "workspace diagnostics" })
vim.keymap.set("n", "<leader>a", fzf.lsp_acde_actions, { desc = "code actions" })
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "lsp help" })
vim.keymap.set("n", "<leader>H", function()
	vim.lsp.buf.signature_help({ border = "rounded" })
end, { desc = "lsp signatures help" })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>f", function()
	conform.format({ lsp_fallback = true })
end, opts)

-- set capabilities for all installed lsp servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end
