vim.opt.guifont = "JetBrainsMono Nerd Font:h16"
vim.cmd("syntax on")
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.splitright = true
vim.opt.splitbelow = true

require("config.lazy")

-- telescope
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set('n', "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set('n', "<leader>fg", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")

-- toggleterm
require("toggleterm").setup {
  direction = "horizontal",
}

vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- bufferline
require("bufferline").setup({
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "Explorer",
        text_align = "center",  -- or "left" / "right"
      }
    }
  }
})
