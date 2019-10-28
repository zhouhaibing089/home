set number
syntax on

set cc=80

" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" tree view
Plug 'scrooloose/nerdtree'
" starter screen
Plug 'mhinz/vim-startify'
" vim plugin for Go programming language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Auto pair
Plug 'jiangmiao/auto-pairs'
" Rust plugin
Plug 'rust-lang/rust.vim'
" Initialize plugin system
call plug#end()

" toggle NERDTree
autocmd VimEnter * NERDTree | wincmd p

set bg=dark
colorscheme solarized
