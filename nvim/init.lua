vim.cmd("syntax on")
vim.opt.termguicolors = false
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.splitright = true
vim.opt.splitbelow = true

require("config.lazy")

-- telescope and its extensions
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
        },
        ["n"] = {
        },
      },
      grouped = true,
      hidden = true,
      hide_parent_dir = true,
    },
  },
}
require("telescope").load_extension "file_browser"

vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set('n', "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set('n', "<leader>fg", ":Telescope live_grep<CR>")

-- toggleterm
require("toggleterm").setup {
  direction = "float",
}

vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
