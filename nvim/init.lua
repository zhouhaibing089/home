vim.cmd("syntax on")
vim.opt.termguicolors = false
vim.opt.number = true
vim.opt.relativenumber = true
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
    },
  },
}
require("telescope").load_extension "file_browser"

-- keybindings
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>")
vim.keymap.set('n', '<leader>fh', ":Telescope help_tags<CR>")
