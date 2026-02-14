vim.cmd("syntax on")
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mmp = 5000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.fillchars = {
	vert = "│",
}
vim.opt.title = true
vim.opt.signcolumn = "yes:1"

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
