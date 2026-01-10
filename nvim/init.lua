vim.cmd("syntax on")
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mmp = 2000

-- disable all neovide animations
vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
-- make floating window semi-transparent
vim.o.winblend = 20
vim.o.pumblend = 20
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

require("config.lazy")

-- neo-tree
vim.keymap.set("n", "<leader>nt", ":Neotree source=filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nr", ":Neotree source=filesystem reveal<CR>")
vim.api.nvim_create_autocmd("User", {
	pattern = "NeoTreeRootChanged",
	callback = function(args)
		vim.cmd("cd " .. args.data.path)
	end,
})

-- fzf
vim.env.BAT_THEME = "Solarized (dark)"
vim.g.fzf_preview_window = { "down:50%" }
vim.g.fzf_files_options = table.concat({
	'--preview "bat --color=always {}"',
}, " ")
vim.keymap.set("n", "<leader>ff", ":Files<CR>")
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Rg<CR>")
vim.keymap.set("n", "<leader>ft", ":Tags<CR>")

-- toggleterm
vim.keymap.set("n", "<leader>tf", ":ToggleTerm<CR>")
vim.keymap.set("n", "<leader>tb", ":ToggleTerm direction=horizontal<CR>")

-- lspconfig
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- solarized
vim.cmd.colorscheme("solarized")

-- aerial
vim.keymap.set("n", "<leader>ds", ":AerialToggle!<CR>")
