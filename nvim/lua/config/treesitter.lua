require('nvim-treesitter').install { 'terraform', 'c', 'python', 'go' }
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
