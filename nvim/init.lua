vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.cmd("syntax on")
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.splitright = true
vim.opt.splitbelow = true

require("config.lazy")

-- neo-tree
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

-- fzf
vim.g.fzf_files_options = table.concat({
	'--preview "bat --color=always {}"',
	"--preview-window right:40%",
}, " ")
vim.keymap.set("n", "<leader>ff", ":Files<CR>")
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Rg<CR>")
vim.keymap.set("n", "<leader>ft", ":Tags<CR>")

-- toggleterm
require("toggleterm").setup({
	direction = "float",
})

vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- bufferline
require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "",
				text_align = "center", -- or "left" / "right"
			},
		},
	},
})

-- lspconfig
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, opts)
