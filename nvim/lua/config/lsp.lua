local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")
local conform = require("conform")

-- disable lsp logging by default
vim.lsp.log.set_level("OFF")

-- These are the most significant keybindings, so making it short
vim.keymap.set("n", "<leader>d", fzf.lsp_definitions, { desc = "definitions" })
vim.keymap.set("n", "<leader>D", fzf.lsp_declarations, { desc = "declarations" })
vim.keymap.set("n", "<leader>i", fzf.lsp_implementations, { desc = "implementations" })
vim.keymap.set("n", "<leader>r", fzf.lsp_references, { desc = "references" })
vim.keymap.set("n", "<leader>e", fzf.diagnostics_document, { desc = "document diagnostics" })
vim.keymap.set("n", "<leader>E", fzf.diagnostics_workspace, { desc = "workspace diagnostics" })
vim.keymap.set("n", "<leader>a", fzf.lsp_code_actions, { desc = "code actions" })
vim.keymap.set("n", "<leader>s", function()
	fzf.lsp_document_symbols()
end, { desc = "document symbols" })
vim.keymap.set("n", "<leader>S", function()
	local query = vim.fn.expand("<cword>")
	if query ~= "" then
		query = "'" .. query
	end
	fzf.lsp_document_symbols({
		query = query,
	})
end, { desc = "document symbols <cword>" })
vim.keymap.set("v", "<leader>s", function()
	fzf.lsp_document_symbols({
		query = utils.get_visual_selection(),
	})
end, { desc = "document symbols" })
vim.keymap.set("n", "<leader>c", fzf.lsp_incoming_calls, { desc = "incoming calls" })
vim.keymap.set("n", "<leader>C", fzf.lsp_outgoing_calls, { desc = "outgoing calls" })
vim.keymap.set("n", "<leader>t", fzf.lsp_typedefs, { desc = "type definitions" })
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

local servers = require("mason-lspconfig").get_installed_servers()

-- set capabilities for all installed lsp servers
local capabilities = require("blink.cmp").get_lsp_capabilities({
	-- workspace/didChangeWatchedFiles can cause poor performance
	workspace = nil,
})
for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end

-- vim global variable is implicit
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
-- gopls root dir
local gopls_root_dir = assert(vim.lsp.config.gopls.root_dir)
vim.lsp.config("gopls", {
	root_dir = function(bufnr, on_dir)
		local file = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.root(file, "pyproject.toml")
		if root then
			on_dir(root)
		else
			gopls_root_dir(bufnr, on_dir)
		end
	end,
	settings = {
		gopls = {
			expandWorkspaceToModule = false,
		},
	},
})

-- disable semanticTokensProvider for terraformls as there is currently a bug
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "terraformls" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- enable all installed servers
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
