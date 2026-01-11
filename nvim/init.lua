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
-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

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
-- RgHere limits rg in current buffer's directory
vim.cmd([[
command! -bang -nargs=* RgHere
  \ call fzf#vim#grep(
  \ "rg --column -n -L --no-heading --color=always --smart-case -. -- "
  \   . fzf#shellescape(<q-args>)
  \   . " "
  \   . expand("%:p:.:h"),
  \ fzf#vim#with_preview({ "options": [
  \   "--delimiter", ":",
  \   "--nth", "4..",
  \   "--with-nth", "1,2,3,4..",
  \ ] }),
  \ <bang>0)
]])
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column -n -L --no-heading --color=always --smart-case -. -- "
  \   . fzf#shellescape(<q-args>),
  \ fzf#vim#with_preview({ "options": [
  \   "--delimiter", ":",
  \   "--nth", "4..",
  \   "--with-nth", "1,2,3,4..",
  \ ] }),
  \ <bang>0)
]])
vim.env.BAT_THEME = "Solarized (dark)"
vim.env.FZF_DEFAULT_OPTS = "--history=" .. os.getenv("HOME") .. "/.fzf_history"
vim.g.fzf_preview_window = { "down:50%" }
vim.g.fzf_files_options = table.concat({
	'--preview "bat --color=always {}"',
}, " ")
-- ff (current buffer's directory), fF (workspace)
vim.keymap.set("n", "<leader>ff", ":Files %:p:.:h<CR>")
vim.keymap.set("n", "<leader>fF", ":Files<CR>")
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>")
-- fg (current buffer's directory), fG (workspace)
vim.keymap.set("n", "<leader>fg", ":RgHere<CR>")
vim.keymap.set("n", "<leader>fG", ":Rg<CR>")
vim.keymap.set("n", "<leader>ft", ":Tags<CR>")

-- toggleterm
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
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
