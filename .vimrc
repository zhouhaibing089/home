set number
syntax on

set backspace=2
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
" Initialize plugin system
call plug#end()

set bg=dark
colorscheme solarized
