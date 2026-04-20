require('neovim-treesitter').install { 'terraform', 'c', 'python', 'go' }
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'terraform', 'c', 'python', 'go' },
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
