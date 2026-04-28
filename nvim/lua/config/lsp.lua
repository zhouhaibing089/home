local fzf = require("fzf-lua")
local conform = require("conform")

-- These are the most significant keybindings, so making it short
vim.keymap.set("n", "<leader>d", fzf.lsp_definitions, { desc = "definitions" })
vim.keymap.set("n", "<leader>D", fzf.lsp_declarations, { desc = "declarations" })
vim.keymap.set("n", "<leader>I", fzf.lsp_implementations, { desc = "implementations" })
vim.keymap.set("n", "<leader>r", fzf.lsp_references, { desc = "references" })
vim.keymap.set("n", "<leader>e", fzf.diagnostics_document, { desc = "document diagnostics" })
vim.keymap.set("n", "<leader>E", fzf.diagnostics_workspace, { desc = "workspace diagnostics" })
vim.keymap.set("n", "<leader>a", fzf.lsp_code_actions, { desc = "code actions" })
vim.keymap.set("n", "<leader>s", fzf.lsp_document_symbols, { desc = "document symbols" })
vim.keymap.set("n", "<leader>c", fzf.lsp_incoming_calls, { desc = "incoming calls" })
vim.keymap.set("n", "<leader>C", fzf.lsp_outgoing_calls, { desc = "outgoing calls" })
vim.keymap.set("n", "<leader>h", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "lsp help" })
vim.keymap.set("n", "<leader>H", function()
	vim.lsp.buf.signature_help({ border = "rounded" })
end, { desc = "lsp signatures help" })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, { desc = "rename" })
vim.keymap.set("n", "<leader>f", function()
	conform.format({ lsp_fallback = true })
end, { desc = "lsp format" })

-- set capabilities for all installed lsp servers
local capabilities = require("blink.cmp").get_lsp_capabilities()
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end

-- disable semanticTokensProvider for terraformls as there is currently a bug
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "terraformls" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
